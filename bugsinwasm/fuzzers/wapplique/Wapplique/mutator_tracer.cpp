#include <stdio.h>
#include <vector>
#include <string>
#include <string.h>
#include <iostream>
#include <fstream>
#include <filesystem>
#include <algorithm>
#include <random>
#include <cassert>
#include <map>
#include "wtype.h"
#include "coding.h"
using namespace std;

std::vector<std::string> used_ingredients;
std::string seed_file;
std::ofstream log_file; // File handle for JSON log

std::random_device rd;
std::mt19937 e(rd());
std::uniform_int_distribution<uint64_t> u(0, 2000);

int rand() {
    return u(e);
}

uint8_t wasmBuffer[10000000];
bool checkInstr[10000000];
vector<uint8>TypeInfo[1000];
vector<uint8>TypeInfoRet[1000];
vector<pair<uint32, uint8>>Locals;
vector<pair<uint8, uint8>>Globals;
vector<uint32>FuncType;
vector<uint8>curStack;
vector<uint8>postStack;
vector<pair<int, uint8>>localused;
vector<pair<int, uint8>>globalused;
vector<int>funcRefTable[200];
int import_cnt = 0;
const int MEM_LIM = 255;
vector<string>splits;
bool SplitMod = false;
int skip_block = 0;
bool MutationMod = false;
bool SimpleMutationMod = false;
// #define debugON
#ifdef debugON
    #define debug(x) (cout << x << endl)
#else
    #define debug(x) 
#endif

void ClearStack() {
    postStack.clear();
    curStack.clear();
    localused.clear();
    globalused.clear();
}

uint8 TryPop() {
    if(skip_block != 0) return I32;
    // printf("TryPop unkown type\n");
    if(curStack.size() == 0) {
        postStack.push_back((uint8)TBD);
        return TBD;
    }
    uint8 ret = curStack.back();
    curStack.pop_back();
    return ret;
}

static std::string extractOriginName(const std::string &splitPath) {
    std::ifstream in{splitPath};
    if (!in) return "";

    std::string line, last;
    while (std::getline(in, line)) {
        if (!line.empty()) last = line;
    }
    // turn "/…/seed-0.wasm" → "seed-0.wasm"
    return std::filesystem::path(last).filename().string();
}

void TryPop(uint8 t) {
    if(skip_block != 0) return;
    // printf("TryPop %u\n", t);
    if(curStack.size() == 0) {
        postStack.push_back(t);
        return;
    }
    uint8 curType = curStack.back();
    if(curType == TBD) {
        curStack.pop_back();
        return;
    }
    if(curType != (uint8)t) {
        // I think it will not happen in generateInfo
        // cout << "Element type is not the same " << +curType << " " << +t << endl;
        // Maybe need to insert a convert instruction?
    }
    curStack.pop_back();
}

void Push(uint8 t) {
    if(skip_block != 0) return;
    // printf("Push %u\n", t);
    curStack.push_back((uint8)t);
}

uint8 GetLocal(int id) {
    int tot = 0;
    for(auto p : Locals) {
        int cnt = p.first;
        uint8 type = p.second;
        if(cnt + tot > id) {
            pair<int, uint8> locl = make_pair(id, type);
            if(find(localused.begin(), localused.end(), locl) == localused.end())
                localused.push_back(locl);
            // debug("Local get " << +type);
            return type;
        }
        tot += cnt;
    }
    printf("Wrong Local ID %d Maybe?\n", id);
    return (uint8)I32;
}

uint8 GetGlobal(int id) {
    if(id > Globals.size()) {
        printf("Wrong Gobal ID Maybe?\n");
        return (uint8)I32;
    }
    pair<int, uint8> globl = make_pair(id, Globals[id].first);
    if(find(globalused.begin(), globalused.end(), globl) == globalused.end())
        globalused.push_back(globl);
    return Globals[id].first;
}

uint32 readu32(int &pos, uint8 *buffer) {
    uint32_t Result = 0;
    uint32_t Offset = 0;
    uint8 Byte = 0x80;
    while (Byte & 0x80) {
        Byte = buffer[pos++];
        // cout << hex << +(Byte & UINT32_C(0x7F)) << endl;
        Result |= (Byte & UINT32_C(0x7F)) << Offset;
        Offset += 7;
    }
    return Result;
}

void writeu32(vector<uint8>&newCode, uint32 result) {
    do {
        // debug(result);
        uint8 byte = result & UINT32_C(0x7F);
        result >>= 7;
        if(result > 0) byte |= 0x80;
        newCode.push_back(byte);
    } while(result);
    // debug(' ');
}

template<typename retType, int N>retType readsN(int &pos, uint8 *buffer) {
    retType Result = 0;
    uint8 Offset = 0;
    uint8 RemainingBits = N;
    while(true) {
        uint8 Byte = buffer[pos++];
        uint8 HighestBitMask = 1 << 7;
        uint8 SecondHighestBitMask = 1 << 6;
        if (Byte & HighestBitMask) {
            // The byte has leading 1. It contains 7 bits payload.
            make_unsigned_t<retType> Payload = Byte & (~HighestBitMask); // & 0b01111111
            Result |= (Payload << Offset);
            Offset += 7;
            RemainingBits -= 7;
        } else {
            // The byte has leading 0. It will be the last byte.
            // The number of bits that take effect in the byte. Since RemainingBits
            // must be at least 1, EffectiveBits also must be at least 1. It is also
            // at most 7.
            retType Payload = Byte;
            if (Byte & SecondHighestBitMask) {
                // The byte is signed.
                Payload -= (1 << 7);
            } else {
                // The byte is unsigned.
            }
            Result |= (Payload << Offset);
            break;
        }
    }
    return Result;
}

template<typename retType, int N>void writesN(retType res, vector<uint8>&code) {
    uint8 Offset = 0;
    int RemainingBits = N;
    retType f = 0;
    if(res < 0) f = -1;
    do {
        uint8 HighestBitMask = 1 << 7;
        uint8 SecondHighestBitMask = 1 << 6;
        uint8 Byte = res & (~HighestBitMask);
        // cout << hex << +Byte << ' ';
        res >>= 7;
        if(res != f) {
            // cout << "Normal Write" << endl;
            code.push_back(Byte | HighestBitMask);
        } else {
            if(f == 0) {
                // cout << " f = 0 " << endl;
                if(Byte & SecondHighestBitMask) {
                    // cout << "More one byte" << endl;
                    code.push_back(Byte | HighestBitMask);
                    code.push_back(0);
                } else code.push_back(Byte);
            } else {
                // cout <<  " f= -1" << endl;
                if(Byte & SecondHighestBitMask) {
                    code.push_back(Byte);
                } else {
                    // cout << "More one byte" << endl;
                    code.push_back(Byte | HighestBitMask);
                    code.push_back(~HighestBitMask);
                }
            }
            break;
        }
        RemainingBits -= 7;
    } while(res && RemainingBits > 0);
}

int reads32(int &pos, uint8*buffer) {
    return readsN<int, 32>(pos, buffer);
}

int64 reads64(int &pos, uint8 *buffer) {
    return readsN<int64, 64>(pos, buffer);
}

int64 reads33(int &pos, uint8 *buffer) {
    return readsN<int64, 33>(pos, buffer);
}

void writes32(int res, vector<uint8>&code) {
    writesN<int, 32>(res, code);
}

void writes33(int res, vector<uint8>&code) {
    writesN<int64, 33>(res, code);
}

void writes64(int res, vector<uint8>&code) {
    writesN<int, 64>(res, code);
}

int64 readu64(int &pos, uint8*buffer) {
    int64 Result = 0;
    uint32_t Offset = 0;
    uint8 Byte = 0x80;
    while (Byte & 0x80) {
        Byte = buffer[pos++];
        // cout << hex << +(Byte & UINT32_C(0x7F)) << endl;
        Result |= (Byte & UINT64_C(0x7F)) << Offset;
        Offset += 7;
    }
    return Result;
}

int instrDep[100000000];

vector<uint8>recpStack[20],reccStack[20];
bool isIF[20];

void recordStack(int dep) {
    recpStack[dep].clear();
    reccStack[dep].clear();
    for(auto k : postStack)
        recpStack[dep].push_back(k);
    for(auto k : curStack)
        reccStack[dep].push_back(k);
}

void resumeStack(int dep) {
    postStack.clear();
    curStack.clear();
    for(auto k : recpStack[dep])
        postStack.push_back(k);
    for(auto k : reccStack[dep])
        curStack.push_back(k);
}

// give code start address and end address
bool GenerateInfo(int p, int p_end, bool can_return = true) {
    ClearStack();
    uint8 opcode;
    uint32 local_idx, global_idx, align, mem_offset, opcode1;
    int i32_const;
    int64 i64_const;
    int block_dep = 0, jump_dep = 0;
    skip_block = 0;

    while (p < p_end) {
        checkInstr[p] = true;
        instrDep[p] = block_dep;
        opcode = wasmBuffer[p++];

        switch (opcode) {
            case WASM_OP_UNREACHABLE:
                debug("UNREACHABLE");
                if(can_return)
                    return false;

            case WASM_OP_NOP:
                debug("NOP");
                break;

            case WASM_OP_IF:
                TryPop(I32);
                [[fallthrough]]
            case WASM_OP_BLOCK:
            case WASM_OP_LOOP:
                debug("IF/BLOCK/LOOP");
                i64_const = reads33(p, wasmBuffer);
                if(i64_const != 0x40) {
                    // 0x40 is a empty loop
                    if(i64_const < 0) {
                        Push(0x7f - (i64_const & (0x7f)));
                    } else {
                        for(auto x :TypeInfo[i64_const])
                            TryPop(x);
                        for(auto x :TypeInfoRet[i64_const])
                            Push(x);
                    }
                }
                skip_block += 1;
                block_dep++;
                break;
            case WASM_OP_ELSE:
                if(block_dep == 0 && can_return)
                    return false;
                break;
            case WASM_OP_END:
                debug("END");
                block_dep--;
                if(skip_block > 0) skip_block--;
                if(block_dep < 0) return false;
                break;
            case WASM_OP_BR_IF:
                TryPop(I32);
            case WASM_OP_BR:
                debug("BR");
                jump_dep = readu32(p, wasmBuffer);
                if(block_dep == 0 || jump_dep >= block_dep)
                    if(can_return)
                        return false;
                if(opcode == WASM_OP_BR && skip_block == 0) skip_block = jump_dep + 1;
                break;
            case WASM_OP_BR_TABLE:
                // cout << "BR_TABLE" << endl;
                debug("Start P " << p);
                // for(int i = p; i < p + 5; i++)
                //     cout << hex << +wasmBuffer[i] << dec << ' ';
                // cout << endl;
                jump_dep = readu32(p, wasmBuffer);
                // printf("Br Table cnt %d\n", jump_dep);
                TryPop(I32);
                for(int i = 0; i < jump_dep; i++)
                    readu32(p, wasmBuffer);
                readu32(p, wasmBuffer);
                debug("End P " << p);
                if(can_return)
                    return false;
                break;
            case WASM_OP_RETURN:
                if(can_return)
                    return false;
                break;
            case WASM_OP_CALL_INDIRECT:
            case WASM_OP_RETURN_CALL_INDIRECT:
                global_idx = readu32(p, wasmBuffer);
                TryPop(I32);
            case WASM_OP_CALL:
            case WASM_OP_RETURN_CALL:
                local_idx = readu32(p, wasmBuffer);
                debug("Call" << local_idx);
                if(can_return)
                    return false;
                break;
            case WASM_OP_DROP:
            {
                debug("DROP");
                TryPop();
                break;
            }

            case WASM_OP_SELECT:
            {
                debug("SELECT");
                TryPop(I32);
                uint8 tid = TryPop();
                TryPop(tid);
                Push(tid);
                break;
            }
            case WASM_OP_GET_LOCAL:
            {
                local_idx = readu32(p, wasmBuffer);
                debug("GET_LOCAL " << local_idx);
                Push(GetLocal(local_idx));
                break;
            }

            case WASM_OP_SET_LOCAL:
            {
                local_idx = readu32(p, wasmBuffer);
                debug("SET_LOCAL " << local_idx);
                TryPop(GetLocal(local_idx));
                break;
            }

            case WASM_OP_TEE_LOCAL:
            {
                local_idx = readu32(p, wasmBuffer);
                debug("TEE_LOCAL " << local_idx);
                uint8 local_type = GetLocal(local_idx);
                TryPop(local_type);
                Push(local_type);
                break;
            }

            case WASM_OP_GET_GLOBAL:
            {
                global_idx = readu32(p, wasmBuffer);
                debug("GET_GLOBAL " << global_idx);
                Push(GetGlobal(global_idx));
                break;
            }

            case WASM_OP_SET_GLOBAL:
            {
                global_idx = readu32(p, wasmBuffer);
                debug("SET_GLOBAL " << global_idx);
                uint8 Global_type = GetGlobal(global_idx);
                TryPop(Global_type);
                break;
            }
            /* load */
            case WASM_OP_I32_LOAD:
            case WASM_OP_I32_LOAD8_S:
            case WASM_OP_I32_LOAD8_U:
            case WASM_OP_I32_LOAD16_S:
            case WASM_OP_I32_LOAD16_U:
            case WASM_OP_I64_LOAD:
            case WASM_OP_I64_LOAD8_S:
            case WASM_OP_I64_LOAD8_U:
            case WASM_OP_I64_LOAD16_S:
            case WASM_OP_I64_LOAD16_U:
            case WASM_OP_I64_LOAD32_S:
            case WASM_OP_I64_LOAD32_U:
            case WASM_OP_F32_LOAD:
            case WASM_OP_F64_LOAD:
            /* store */
            case WASM_OP_I32_STORE:
            case WASM_OP_I32_STORE8:
            case WASM_OP_I32_STORE16:
            case WASM_OP_I64_STORE:
            case WASM_OP_I64_STORE8:
            case WASM_OP_I64_STORE16:
            case WASM_OP_I64_STORE32:
            case WASM_OP_F32_STORE:
            case WASM_OP_F64_STORE:
            {
                align = readu32(p, wasmBuffer);;
                mem_offset = readu32(p, wasmBuffer);;
                switch (opcode) {
                    /* load */
                    case WASM_OP_I32_LOAD:
                    case WASM_OP_I32_LOAD8_S:
                    case WASM_OP_I32_LOAD8_U:
                    case WASM_OP_I32_LOAD16_S:
                    case WASM_OP_I32_LOAD16_U:
                        debug("LOAD");
                        TryPop(I32);
                        Push(I32);
                        break;
                    case WASM_OP_I64_LOAD:
                    case WASM_OP_I64_LOAD8_S:
                    case WASM_OP_I64_LOAD8_U:
                    case WASM_OP_I64_LOAD16_S:
                    case WASM_OP_I64_LOAD16_U:
                    case WASM_OP_I64_LOAD32_S:
                    case WASM_OP_I64_LOAD32_U:
                        debug("LOAD");
                        TryPop(I32);
                        Push(I64);
                        break;
                    case WASM_OP_F32_LOAD:
                        debug("LOAD");
                        TryPop(I32);
                        Push(F32);
                        break;
                    case WASM_OP_F64_LOAD:
                        debug("LOAD");
                        TryPop(I32);
                        Push(F64);
                        break;
                    /* store */
                    case WASM_OP_I32_STORE:
                    case WASM_OP_I32_STORE8:
                    case WASM_OP_I32_STORE16:
                        debug("STORE");
                        TryPop(I32);
                        TryPop(I32);
                        break;
                    case WASM_OP_I64_STORE:
                    case WASM_OP_I64_STORE8:
                    case WASM_OP_I64_STORE16:
                    case WASM_OP_I64_STORE32:
                        debug("STORE");
                        TryPop(I64);
                        TryPop(I32);
                        break;
                    case WASM_OP_F32_STORE:
                        debug("STORE");
                        TryPop(F32);
                        TryPop(I32);
                        break;
                    case WASM_OP_F64_STORE:
                        debug("STORE");
                        TryPop(F64);
                        TryPop(I32);
                        break;
                    default:
                        debug("UNKOWN LOAD/STORE");
                        break;
                }
                break;
            }

            case WASM_OP_MEMORY_SIZE:
                debug("MEMORY_SIZE");
                p++; // Maybe Need a check , I dont know why need it
                Push(I32);
                break;

            case WASM_OP_MEMORY_GROW:
                debug("MEMORY_GROW");
                p++;
                TryPop(I32);
                Push(I32);
                break;

            case WASM_OP_I32_CONST:
                debug("I32_CONST");
                i32_const = readu32(p, wasmBuffer);
                Push(I32);
                break;

            case WASM_OP_I64_CONST:
                debug("I64_CONST");
                i64_const = reads64(p, wasmBuffer);
                Push(I64);
                break;

            case WASM_OP_F32_CONST:
                debug("F32_CONST");
                p += 4;
                Push(F32);
                break;

            case WASM_OP_F64_CONST:
                debug("F64_CONST");
                p += 8;
                Push(F64);
                break;

            case WASM_OP_I32_EQZ:
                debug("I32_EQZ");
                TryPop(I32);
                Push(I32);
                break;

            case WASM_OP_I32_EQ:
            case WASM_OP_I32_NE:
            case WASM_OP_I32_LT_S:
            case WASM_OP_I32_LT_U:
            case WASM_OP_I32_GT_S:
            case WASM_OP_I32_GT_U:
            case WASM_OP_I32_LE_S:
            case WASM_OP_I32_LE_U:
            case WASM_OP_I32_GE_S:
            case WASM_OP_I32_GE_U:
                debug("I32_COMPARE");
                TryPop(I32);
                TryPop(I32);
                Push(I32);
                break;

            case WASM_OP_I64_EQZ:
                debug("I64_EQZ");
                TryPop(I64);
                Push(I32);
                break;

            case WASM_OP_I64_EQ:
            case WASM_OP_I64_NE:
            case WASM_OP_I64_LT_S:
            case WASM_OP_I64_LT_U:
            case WASM_OP_I64_GT_S:
            case WASM_OP_I64_GT_U:
            case WASM_OP_I64_LE_S:
            case WASM_OP_I64_LE_U:
            case WASM_OP_I64_GE_S:
            case WASM_OP_I64_GE_U:
                debug("I64_COMPARE");
                TryPop(I64);
                TryPop(I64);
                Push(I32);
                break;

            case WASM_OP_F32_EQ:
            case WASM_OP_F32_NE:
            case WASM_OP_F32_LT:
            case WASM_OP_F32_GT:
            case WASM_OP_F32_LE:
            case WASM_OP_F32_GE:
                debug("F32_COMPARE");
                TryPop(F32);
                TryPop(F32);
                Push(I32);
                break;

            case WASM_OP_F64_EQ:
            case WASM_OP_F64_NE:
            case WASM_OP_F64_LT:
            case WASM_OP_F64_GT:
            case WASM_OP_F64_LE:
            case WASM_OP_F64_GE:
                debug("F64_COMPARE");
                TryPop(F64);
                TryPop(F64);
                Push(I32);
                break;

            case WASM_OP_I32_CLZ:
            case WASM_OP_I32_CTZ:
            case WASM_OP_I32_POPCNT:
                debug("I32_UNKOWN");
                TryPop(I32);
                Push(I32);
                break;

            case WASM_OP_I32_ADD:
            case WASM_OP_I32_SUB:
            case WASM_OP_I32_MUL:
            case WASM_OP_I32_DIV_S:
            case WASM_OP_I32_DIV_U:
            case WASM_OP_I32_REM_S:
            case WASM_OP_I32_REM_U:
            case WASM_OP_I32_AND:
            case WASM_OP_I32_OR:
            case WASM_OP_I32_XOR:
            case WASM_OP_I32_SHL:
            case WASM_OP_I32_SHR_S:
            case WASM_OP_I32_SHR_U:
            case WASM_OP_I32_ROTL:
            case WASM_OP_I32_ROTR:
                debug("I32_MATH");
                TryPop(I32);
                TryPop(I32);
                Push(I32);
                break;

            case WASM_OP_I64_CLZ:
            case WASM_OP_I64_CTZ:
            case WASM_OP_I64_POPCNT:
                debug("I64_UNKOWN");
                TryPop(I64);
                Push(I64);
                break;

            case WASM_OP_I64_ADD:
            case WASM_OP_I64_SUB:
            case WASM_OP_I64_MUL:
            case WASM_OP_I64_DIV_S:
            case WASM_OP_I64_DIV_U:
            case WASM_OP_I64_REM_S:
            case WASM_OP_I64_REM_U:
            case WASM_OP_I64_AND:
            case WASM_OP_I64_OR:
            case WASM_OP_I64_XOR:
            case WASM_OP_I64_SHL:
            case WASM_OP_I64_SHR_S:
            case WASM_OP_I64_SHR_U:
            case WASM_OP_I64_ROTL:
            case WASM_OP_I64_ROTR:
                debug("I64_MATH");
                TryPop(I64);
                TryPop(I64);
                Push(I64);
                break;

            case WASM_OP_F32_ABS:
            case WASM_OP_F32_NEG:
            case WASM_OP_F32_CEIL:
            case WASM_OP_F32_FLOOR:
            case WASM_OP_F32_TRUNC:
            case WASM_OP_F32_NEAREST:
            case WASM_OP_F32_SQRT:
                debug("F32_OP");
                TryPop(F32);
                Push(F32);
                break;

            case WASM_OP_F32_ADD:
            case WASM_OP_F32_SUB:
            case WASM_OP_F32_MUL:
            case WASM_OP_F32_DIV:
            case WASM_OP_F32_MIN:
            case WASM_OP_F32_MAX:
            case WASM_OP_F32_COPYSIGN:
                debug("F32_MATH");
                TryPop(F32);
                TryPop(F32);
                Push(F32);
                break;

            case WASM_OP_F64_ABS:
            case WASM_OP_F64_NEG:
            case WASM_OP_F64_CEIL:
            case WASM_OP_F64_FLOOR:
            case WASM_OP_F64_TRUNC:
            case WASM_OP_F64_NEAREST:
            case WASM_OP_F64_SQRT:
                debug("F64_OP");
                TryPop(F64);
                Push(F64);
                break;

            case WASM_OP_F64_ADD:
            case WASM_OP_F64_SUB:
            case WASM_OP_F64_MUL:
            case WASM_OP_F64_DIV:
            case WASM_OP_F64_MIN:
            case WASM_OP_F64_MAX:
            case WASM_OP_F64_COPYSIGN:
                debug("F64_MATH");
                TryPop(F64);
                TryPop(F64);
                Push(F64);
                break;

            case WASM_OP_I32_WRAP_I64:
                debug("I32_WRAP_I64");
                TryPop(I64);
                Push(I32);
                break;

            case WASM_OP_I32_TRUNC_S_F32:
            case WASM_OP_I32_TRUNC_U_F32:
                debug("I32_TRUNC_F32");
                TryPop(F32);
                Push(I32);
                break;

            case WASM_OP_I32_TRUNC_S_F64:
            case WASM_OP_I32_TRUNC_U_F64:
                debug("I32_TRUNC_F64");
                TryPop(F64);
                Push(I32);
                break;

            case WASM_OP_I64_EXTEND_S_I32:
            case WASM_OP_I64_EXTEND_U_I32:
                debug("EXTEND");
                TryPop(I32);
                Push(I64);
                break;

            case WASM_OP_I64_TRUNC_S_F32:
            case WASM_OP_I64_TRUNC_U_F32:
                TryPop(F32);
                Push(I64);
                break;

            case WASM_OP_I64_TRUNC_S_F64:
            case WASM_OP_I64_TRUNC_U_F64:
                TryPop(F64);
                Push(I64);
                break;

            case WASM_OP_F32_CONVERT_S_I32:
            case WASM_OP_F32_CONVERT_U_I32:
                TryPop(I32);
                Push(F32);
                break;

            case WASM_OP_F32_CONVERT_S_I64:
            case WASM_OP_F32_CONVERT_U_I64:
                TryPop(I64);
                Push(F32);
                break;

            case WASM_OP_F32_DEMOTE_F64:
                TryPop(F64);
                Push(F32);
                break;

            case WASM_OP_F64_CONVERT_S_I32:
            case WASM_OP_F64_CONVERT_U_I32:
                TryPop(I32);
                Push(F64);
                break;

            case WASM_OP_F64_CONVERT_S_I64:
            case WASM_OP_F64_CONVERT_U_I64:
                TryPop(I64);
                Push(F64);
                break;

            case WASM_OP_F64_PROMOTE_F32:
                TryPop(F32);
                Push(F64);
                break;

            case WASM_OP_I32_REINTERPRET_F32:
                TryPop(F32);
                Push(I32);
                break;

            case WASM_OP_I64_REINTERPRET_F64:
                TryPop(F64);
                Push(I64);
                break;

            case WASM_OP_F32_REINTERPRET_I32:
                TryPop(I32);
                Push(F32);
                break;

            case WASM_OP_F64_REINTERPRET_I64:
                TryPop(I64);
                Push(F64);
                break;

            case WASM_OP_I32_EXTEND8_S:
            case WASM_OP_I32_EXTEND16_S:
                TryPop(I32);
                Push(I32);
                break;

            case WASM_OP_I64_EXTEND8_S:
            case WASM_OP_I64_EXTEND16_S:
            case WASM_OP_I64_EXTEND32_S:
                TryPop(I64);
                Push(I64);
                break;

            case WASM_OP_MISC_PREFIX:
            {
                opcode1 = readu32(p, wasmBuffer);
                switch (opcode1) {
                    case WASM_OP_I32_TRUNC_SAT_S_F32:
                    case WASM_OP_I32_TRUNC_SAT_U_F32:
                        TryPop(F32);
                        Push(I32);
                        break;
                    case WASM_OP_I32_TRUNC_SAT_S_F64:
                    case WASM_OP_I32_TRUNC_SAT_U_F64:
                        TryPop(F64);
                        Push(I32);
                        break;
                    case WASM_OP_I64_TRUNC_SAT_S_F32:
                    case WASM_OP_I64_TRUNC_SAT_U_F32:
                        TryPop(F32);
                        Push(I64);
                        break;
                    case WASM_OP_I64_TRUNC_SAT_S_F64:
                    case WASM_OP_I64_TRUNC_SAT_U_F64:
                        TryPop(F64);
                        Push(I64);
                        break;
                    default:
                        // printf("Error in MISC PREFIX\n");
                        return false;
                }
                break;
            }
            default:
                // printf("Unkown Op %u\n", opcode);
                return false;
        }
    }
    if(block_dep == 0)
        return true;
    else return false;
}

map<int, int>SplitCnt;

const int mod = 1e7+7;
string split_file;

int HashID(vector<uint8>&p, vector<uint8>&c) {
    int h = 0;
    for(auto i : p)
        h = (h * 5 + i) % mod;
    h = (h * 5 + 4) % mod;
    for(auto i : c)
        h = (h * 5 + i) % mod;
    return mod;
}

void TrySplit(int p, int p_end, char*dir) {
    for(int i = p; i < p_end; i++)
        checkInstr[i] = false;
    // PrintInstr(p, p_end);
    vector<int>endVec;
    GenerateInfo(p, p_end, 0);
    for(int i = p; i < p_end - 11; i ++) {
        if(checkInstr[i] == true) {
            // Could start here!
            int www = 0;
            for(int ww = 0; ww < 30; ww++){
                int j = rand() % min(p_end - i - 10, 71) + i + 10;
                if(checkInstr[j] != true || instrDep[j] != instrDep[i]) continue;
                www += 1;
                if(GenerateInfo(i, j)){
                    reverse(postStack.begin(), postStack.end());
                    // printf("--------------\n");
                    // PrintInstr(i, j);
                    // for(auto k : postStack) 
                    //     cout << +k << ' ';
                    // cout << endl;
                    // for(auto k : curStack)
                    //     cout << +k << ' ';
                    // cout << endl << "-----" << endl;
                    bool f = true;
                    for(auto k : postStack)
                        if(k == TBD) f = false;
                    for(auto k : curStack)
                        if(k == TBD) f = false;
                    if(f == false) continue;
                    int hash_id = HashID(postStack, curStack);
                    if(SplitCnt.find(hash_id) == SplitCnt.end()) SplitCnt[hash_id] = 0;
                    if(SplitCnt[hash_id] > 3 && (rand() % (5 * SplitCnt[hash_id]) != 0)) continue;
                    SplitCnt[hash_id] ++;
                    int file_id = encoder(dir, wasmBuffer, i, j, curStack, postStack, localused, globalused, split_file);
                    std::cout << file_id << endl;
                    printf("Success at %d with length %d\n", www, j - i);
                    i = j - 1;
                    break;
                    // stringstream ss;
                    // ss << hex << file_id;
                    // print("/home/unicornt/WASM/WasmSynthesis/splits/split-" + ss.str());
                }
            }
        }
    }
}

int GetSuitableLocal(uint8 type) {
    int id = 0;
    int rid = -1;
    for(auto l : Locals) {
        if(l.second == type) {
            if(rid == -1 || rand() & 1)
                rid = id + rand() % l.first;
        }
        id += l.first;
    }
    return rid;
}

int GetSuitableGlobal(uint8 type, bool mut = false) {
    int id = 0;
    int rid = -1;
    for(int i = 1; i < Globals.size(); i++) {
        if(Globals[i].first == type) {
            if(mut) {
                if(Globals[i].second == 1 && ((rand() & 1) || rid == -1) ) rid = i;
            } else {
                if((rand() & 1) || rid == -1) rid = i;
            }
        }
    }
    return rid;
}

void GenPreMem(vector<uint8>&code, uint8 opcode, uint8 type) {
    int id = -1;
    code.pop_back();
    if((id = GetSuitableGlobal(type, true)) != -1) {
        code.push_back(WASM_OP_SET_GLOBAL);
        writeu32(code, id);
    }
    code.push_back(WASM_OP_I32_CONST);
    writes32(MEM_LIM, code);
    code.push_back(WASM_OP_I32_AND);
    code.push_back(WASM_OP_GET_GLOBAL);
    writeu32(code, (uint)id);
    code.push_back(opcode);
}

void addGetGlobal(vector<uint8>&newCode, uint id) {
    newCode.push_back(WASM_OP_GET_GLOBAL);
    writeu32(newCode, id);
}

void addI32Const(vector<uint8>&newCode, int c) {
    newCode.push_back(WASM_OP_I32_CONST);
    writes32(c, newCode);
}

void addCallPrint(vector<uint8>&newCode) {
    // newCode.push_back(WASM_OP_SET_GLOBAL);
    // int id = GetSuitableGlobal(I32);
    // writeu32(newCode, id);
    // addI32Const(newCode, 30330);
    // addGetGlobal(newCode, id);
    // addI32Const(newCode, 30330);
    // newCode.push_back(WASM_OP_I32_LOAD);
    // newCode.push_back(2);
    // newCode.push_back(0);
    // newCode.push_back(WASM_OP_I32_XOR);
    // newCode.push_back(WASM_OP_I32_STORE);
    // newCode.push_back(2);
    // newCode.push_back(0);
    // addGetGlobal(newCode, id);
}

void addFinalPrint(vector<uint8>&newCode) {
    // newCode.push_back(WASM_OP_DROP);
    // addI32Const(newCode, 30330);
    // newCode.push_back(WASM_OP_I32_LOAD);
    // newCode.push_back(2);
    // newCode.push_back(0);
    // addI32Const(newCode, 127);
    // newCode.push_back(WASM_OP_I32_AND);
}

bool TryAddSplitAndFix(vector<uint8>&code, vector<uint8>&newCode, vector<pair<int, uint8>>newlocal, vector<pair<int, uint8>>newglobal) { 
    int p = 0;
    int p_end = code.size();
    uint8 opcode;
    uint32 local_idx, global_idx, align, mem_offset, opcode1;
    int i32_const;
    int64 i64_const;
    int block_dep = 0;
    int p_st = 0;
    
    while (p < p_end) {
        checkInstr[p] = true;
        opcode = code[p++];
        newCode.push_back(opcode);

        switch (opcode) {
            case WASM_OP_UNREACHABLE:
                debug("UNREACHABLE");
                return false;

            case WASM_OP_NOP:
                debug("NOP");
                break;

            case WASM_OP_IF:
            case WASM_OP_BLOCK:
            case WASM_OP_LOOP:
                debug("IF/BLOCK/LOOP");
                p_st = p;
                i64_const = reads33(p, code.data());
                if(i64_const >= 0)
                    return false;
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                block_dep++;
                break;
            case WASM_OP_ELSE:
                break;
            case WASM_OP_END:
                debug("END");
                block_dep--;
                break;
            case WASM_OP_BR:
            case WASM_OP_BR_IF:
                p_st = p;
                readu32(p, code.data());
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                break;
            case WASM_OP_BR_TABLE:
                if(block_dep == 0) return false;
                break;
            case WASM_OP_RETURN:
            case WASM_OP_CALL:
            case WASM_OP_RETURN_CALL:
            case WASM_OP_CALL_INDIRECT:
            case WASM_OP_RETURN_CALL_INDIRECT:
                return false;
            case WASM_OP_DROP:
            {
                break;
            }

            case WASM_OP_SELECT:
            {
                break;
            }
            case WASM_OP_GET_LOCAL:
            {
                local_idx = readu32(p, code.data());
                debug("GET LOCAL " << local_idx);
                for(auto l : newlocal) {
                    if(l.first == local_idx){
                        local_idx = GetSuitableLocal(l.second);
                        break;
                    }
                }
                debug("Change to " << local_idx);
                writeu32(newCode, local_idx);
                break;
            }

            case WASM_OP_SET_LOCAL:
            {
                local_idx = readu32(p, code.data());
                for(auto l : newlocal) {
                    if(l.first == local_idx) {
                        local_idx = GetSuitableLocal(l.second);
                        break;
                    }
                }
                writeu32(newCode, local_idx);
                break;
            }

            case WASM_OP_TEE_LOCAL:
            {
                local_idx = readu32(p, code.data());
                for(auto l : newlocal) {
                    if(l.first == local_idx) {
                        local_idx = GetSuitableLocal(l.second);
                        break;
                    }
                }
                writeu32(newCode, local_idx);
                break;
            }

            case WASM_OP_GET_GLOBAL:
            {
                global_idx = readu32(p, code.data());
                for(auto l : newglobal) {
                    if(l.first == global_idx) {
                        global_idx = GetSuitableGlobal(l.second);
                        break;
                    }
                }
                writeu32(newCode, global_idx);
                break;
            }

            case WASM_OP_SET_GLOBAL:
            {
                global_idx = readu32(p, code.data());
                for(auto l : newglobal) {
                    if(l.first == global_idx) {
                        global_idx = GetSuitableGlobal(l.second);
                        break;
                    }
                }
                writeu32(newCode, global_idx);
                break;
                // Push(Global_type);
            }
            /* load */
            case WASM_OP_I32_LOAD:
            case WASM_OP_I32_LOAD8_S:
            case WASM_OP_I32_LOAD8_U:
            case WASM_OP_I32_LOAD16_S:
            case WASM_OP_I32_LOAD16_U:
            case WASM_OP_I64_LOAD:
            case WASM_OP_I64_LOAD8_S:
            case WASM_OP_I64_LOAD8_U:
            case WASM_OP_I64_LOAD16_S:
            case WASM_OP_I64_LOAD16_U:
            case WASM_OP_I64_LOAD32_S:
            case WASM_OP_I64_LOAD32_U:
            case WASM_OP_F32_LOAD:
            case WASM_OP_F64_LOAD:
                newCode.pop_back();
                newCode.push_back(WASM_OP_I32_CONST);
                writes32(MEM_LIM, newCode);
                newCode.push_back(WASM_OP_I32_AND);
                newCode.push_back(opcode);
                p_st = p;
                align = readu32(p, code.data());
                mem_offset = readu32(p, code.data());
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                break;
            /* store */
            case WASM_OP_I32_STORE:
            case WASM_OP_I32_STORE8:
            case WASM_OP_I32_STORE16:
                GenPreMem(newCode, opcode, I32);
                p_st = p;
                align = readu32(p, code.data());
                mem_offset = readu32(p, code.data());
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                break;
            case WASM_OP_I64_STORE:
            case WASM_OP_I64_STORE8:
            case WASM_OP_I64_STORE16:
            case WASM_OP_I64_STORE32:
                GenPreMem(newCode, opcode, I64);
                p_st = p;
                align = readu32(p, code.data());
                mem_offset = readu32(p, code.data());
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                break;
            case WASM_OP_F32_STORE:
                GenPreMem(newCode, opcode, F32);
                p_st = p;
                align = readu32(p, code.data());
                mem_offset = readu32(p, code.data());
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                break;
            case WASM_OP_F64_STORE:
            {
                GenPreMem(newCode, opcode, F64);
                p_st = p;
                align = readu32(p, code.data());
                mem_offset = readu32(p, code.data());
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                break;
            }

            case WASM_OP_MEMORY_SIZE:
            case WASM_OP_MEMORY_GROW:
                newCode.push_back(code[p++]);
                break;

            case WASM_OP_I32_CONST:
                p_st = p;
                i32_const = readu32(p, code.data());
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                (void)i32_const;
                break;

            case WASM_OP_I64_CONST:
                p_st = p;
                i64_const = reads64(p, code.data());
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                break;

            case WASM_OP_F32_CONST:
                p_st = p;
                p += 4;
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                break;

            case WASM_OP_F64_CONST:
                p_st = p;
                p += 8;
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                break;

            case WASM_OP_I32_EQZ:
                break;

            case WASM_OP_I32_EQ:
            case WASM_OP_I32_NE:
            case WASM_OP_I32_LT_S:
            case WASM_OP_I32_LT_U:
            case WASM_OP_I32_GT_S:
            case WASM_OP_I32_GT_U:
            case WASM_OP_I32_LE_S:
            case WASM_OP_I32_LE_U:
            case WASM_OP_I32_GE_S:
            case WASM_OP_I32_GE_U:
                addCallPrint(newCode);
                break;

            case WASM_OP_I64_EQZ:
                break;

            case WASM_OP_I64_EQ:
            case WASM_OP_I64_NE:
            case WASM_OP_I64_LT_S:
            case WASM_OP_I64_LT_U:
            case WASM_OP_I64_GT_S:
            case WASM_OP_I64_GT_U:
            case WASM_OP_I64_LE_S:
            case WASM_OP_I64_LE_U:
            case WASM_OP_I64_GE_S:
            case WASM_OP_I64_GE_U:
                break;

            case WASM_OP_F32_EQ:
            case WASM_OP_F32_NE:
            case WASM_OP_F32_LT:
            case WASM_OP_F32_GT:
            case WASM_OP_F32_LE:
            case WASM_OP_F32_GE:
                break;

            case WASM_OP_F64_EQ:
            case WASM_OP_F64_NE:
            case WASM_OP_F64_LT:
            case WASM_OP_F64_GT:
            case WASM_OP_F64_LE:
            case WASM_OP_F64_GE:
                break;

            case WASM_OP_I32_CLZ:
            case WASM_OP_I32_CTZ:
            case WASM_OP_I32_POPCNT:
                break;

            case WASM_OP_I32_DIV_S:
            case WASM_OP_I32_DIV_U:
            case WASM_OP_I32_REM_S:
            case WASM_OP_I32_REM_U:
                newCode.pop_back();
                addI32Const(newCode, 1);
                newCode.push_back(WASM_OP_I32_OR);
                newCode.push_back(opcode);
            case WASM_OP_I32_MUL:
            case WASM_OP_I32_ADD:
            case WASM_OP_I32_SUB:
            case WASM_OP_I32_AND:
            case WASM_OP_I32_OR:
            case WASM_OP_I32_XOR:
            case WASM_OP_I32_SHL:
            case WASM_OP_I32_SHR_S:
            case WASM_OP_I32_SHR_U:
            case WASM_OP_I32_ROTL:
            case WASM_OP_I32_ROTR:
                addCallPrint(newCode);
                break;
            case WASM_OP_I64_DIV_S:
            case WASM_OP_I64_DIV_U:
            case WASM_OP_I64_REM_S:
            case WASM_OP_I64_REM_U:
                newCode.pop_back();
                newCode.push_back(WASM_OP_I64_CONST);
                writes64(1, newCode);
                newCode.push_back(WASM_OP_I64_OR);
                newCode.push_back(opcode);
                break;
            case WASM_OP_I64_CLZ:
            case WASM_OP_I64_CTZ:
            case WASM_OP_I64_POPCNT:
            case WASM_OP_I64_ADD:
            case WASM_OP_I64_SUB:
            case WASM_OP_I64_MUL:
            case WASM_OP_I64_AND:
            case WASM_OP_I64_OR:
            case WASM_OP_I64_XOR:
            case WASM_OP_I64_SHL:
            case WASM_OP_I64_SHR_S:
            case WASM_OP_I64_SHR_U:
            case WASM_OP_I64_ROTL:
            case WASM_OP_I64_ROTR:
            case WASM_OP_F32_ABS:
            case WASM_OP_F32_NEG:
            case WASM_OP_F32_CEIL:
            case WASM_OP_F32_FLOOR:
            case WASM_OP_F32_TRUNC:
            case WASM_OP_F32_NEAREST:
            case WASM_OP_F32_SQRT:
            case WASM_OP_F32_ADD:
            case WASM_OP_F32_SUB:
            case WASM_OP_F32_MUL:
            case WASM_OP_F32_DIV:
            case WASM_OP_F32_MIN:
            case WASM_OP_F32_MAX:
            case WASM_OP_F32_COPYSIGN:
            case WASM_OP_F64_ABS:
            case WASM_OP_F64_NEG:
            case WASM_OP_F64_CEIL:
            case WASM_OP_F64_FLOOR:
            case WASM_OP_F64_TRUNC:
            case WASM_OP_F64_NEAREST:
            case WASM_OP_F64_SQRT:
            case WASM_OP_F64_ADD:
            case WASM_OP_F64_SUB:
            case WASM_OP_F64_MUL:
            case WASM_OP_F64_DIV:
            case WASM_OP_F64_MIN:
            case WASM_OP_F64_MAX:
            case WASM_OP_F64_COPYSIGN:
            case WASM_OP_I32_WRAP_I64:
            case WASM_OP_I32_TRUNC_S_F32:
            case WASM_OP_I32_TRUNC_U_F32:
            case WASM_OP_I32_TRUNC_S_F64:
            case WASM_OP_I32_TRUNC_U_F64:
                break;

            case WASM_OP_I64_EXTEND_S_I32:
            case WASM_OP_I64_EXTEND_U_I32:
                debug("EXTEND");
            case WASM_OP_I64_TRUNC_S_F32:
            case WASM_OP_I64_TRUNC_U_F32:
            case WASM_OP_I64_TRUNC_S_F64:
            case WASM_OP_I64_TRUNC_U_F64:
            case WASM_OP_F32_CONVERT_S_I32:
            case WASM_OP_F32_CONVERT_U_I32:
            case WASM_OP_F32_CONVERT_S_I64:
            case WASM_OP_F32_CONVERT_U_I64:
            case WASM_OP_F32_DEMOTE_F64:
            case WASM_OP_F64_CONVERT_S_I32:
            case WASM_OP_F64_CONVERT_U_I32:
            case WASM_OP_F64_CONVERT_S_I64:
            case WASM_OP_F64_CONVERT_U_I64:
            case WASM_OP_F64_PROMOTE_F32:
            case WASM_OP_I32_REINTERPRET_F32:
            case WASM_OP_I64_REINTERPRET_F64:
            case WASM_OP_F32_REINTERPRET_I32:
            case WASM_OP_F64_REINTERPRET_I64:
            case WASM_OP_I32_EXTEND8_S:
            case WASM_OP_I32_EXTEND16_S:
            case WASM_OP_I64_EXTEND8_S:
            case WASM_OP_I64_EXTEND16_S:
            case WASM_OP_I64_EXTEND32_S:
                break;

            case WASM_OP_MISC_PREFIX:
            {
                p_st = p;
                opcode1 = readu32(p, code.data());
                for(int w = p_st; w < p; w++)
                    newCode.push_back(code[w]);
                break;
            }
            default:
                printf("Unkown Op %u\n", opcode);
                return false;
        }
    }
}

void LoadInitExpr(int &pos, int p_end, uint8 *buffer) {
    while(pos < p_end) {
        uint8 opcode = buffer[pos++];
        switch(opcode) {
        case WASM_OP_END:
            return;
        case WASM_OP_I32_CONST:
            reads32(pos, buffer);
            break;
        case WASM_OP_I64_CONST:
            reads64(pos, buffer);
            break;
        case WASM_OP_F32_CONST:
            pos += 4;
            break;
        case WASM_OP_F64_CONST:
            pos += 8;
            break;
        case WASM_OP_GET_GLOBAL:
            readu32(pos, buffer);
            break;
        default:
            cerr << "Load Init Expr meet unkown expr\n" << endl;
            break;
        }
    }
}

void GenRandInit(vector<uint8>&newCode, uint8 type) {
    switch(type) {
    case 0:
        newCode.push_back(WASM_OP_I32_CONST);
        writes32(rand(), newCode);
        break;
    case 1:
        newCode.push_back(WASM_OP_I64_CONST);
        writes64(rand(), newCode);
        break;
    case 2:
        newCode.push_back(WASM_OP_F32_CONST);
        for(int i = 0; i < 4; i++)
            newCode.push_back(rand() & 0xff);
        break;
    case 3:
        newCode.push_back(WASM_OP_F64_CONST);
        for(int i = 0; i < 8; i++)
            newCode.push_back(rand() & 0xff);
        break;
    }
}

uint8 GenRandMath(uint8 type) {
    switch(type) {
    case 0:
        return WASM_OP_I32_ADD + rand() % 15;
    case 1:
        return WASM_OP_I64_ADD + rand() % 15;
    case 2:
        return WASM_OP_F32_ADD + rand() % 7;
    case 3:
        return WASM_OP_F64_ADD + rand() % 7;
    }
}

uint8 GenConvert(uint8 ta, uint8 tb) {
    switch(ta) {
    case 0:
        switch(tb) {
        case 1:
            return WASM_OP_I64_EXTEND_S_I32;
        case 2:
            return WASM_OP_F32_CONVERT_S_I32;
        case 3:
            return WASM_OP_F64_CONVERT_S_I32;
        }
        break;
    case 1:
        switch(tb) {
        case 0:
            return WASM_OP_I32_WRAP_I64;
        case 2:
            return WASM_OP_F32_CONVERT_S_I64;
        case 3:
            return WASM_OP_F64_CONVERT_S_I64;
        }
        break;
    case 2:
        switch(tb) {
        case 0:
            return WASM_OP_I32_TRUNC_S_F32;
        case 1:
            return WASM_OP_I64_TRUNC_S_F32;
        case 3:
            return WASM_OP_F64_PROMOTE_F32;
        }
        break;
    case 3:
        switch(tb) {
        case 0:
            return WASM_OP_I32_TRUNC_S_F64;
        case 1:
            return WASM_OP_I64_TRUNC_S_F64;
        case 2:
            return WASM_OP_F32_DEMOTE_F64;
        }
        break;
    }
}

int CalcFixDistance(vector<uint8>n, vector<uint8>t) {
    int mid = 0;
    for(; mid < n.size() && mid < t.size() && n[mid] == t[mid]; mid++);
    int cnt = 0;
    while(t.size() - mid >= 2) {
        uint8 a = t.back();
        t.pop_back();
        uint8 b = t.back();
        cnt += (a == b);
        cnt ++;
    }
    if(t.size() != mid) cnt++;
    return cnt + n.size() - mid;
}

void AddRandMath(vector<uint8>&newCode, uint8 t) {
    uint8 op = GenRandMath(t);
    if(op == WASM_OP_I32_DIV_S || op == WASM_OP_I32_DIV_U || op == WASM_OP_I32_REM_S || op == WASM_OP_I32_REM_U){
        addI32Const(newCode, 1);
        newCode.push_back(WASM_OP_I32_OR);
    }
    if(op == WASM_OP_I64_DIV_S || op == WASM_OP_I64_DIV_U || op == WASM_OP_I64_REM_S || op == WASM_OP_I64_REM_U) {
        newCode.push_back(WASM_OP_I64_CONST);
        writes32(1, newCode);
        newCode.push_back(WASM_OP_I64_OR);
    }
    newCode.push_back(op);
}

void AddFixCode(vector<uint8>&newCode, vector<uint8>&ps, vector<uint8>&cs) {
    int match_id = 0;
    for(; match_id < cs.size() && match_id < ps.size() && ps[match_id] == cs[match_id]; match_id++);
    if(match_id == cs.size()) {
        while(ps.size() - cs.size() >= 2) {
            uint8 ta = ps[ps.size() - 1];
            uint8 tb = ps[ps.size() - 2];
            if(ta == tb || ta == 4 || tb == 4) {
                if(ta == 4) ta = tb;
                if(ta == 4) ta = I32;
                AddRandMath(newCode, ta);
                ps.pop_back();
                ps.pop_back();
                ps.push_back(ta);
            } else {
                newCode.push_back(GenConvert(ta, tb));
                AddRandMath(newCode, tb);
                ps.pop_back();
                ps.pop_back();
                ps.push_back(tb);
            }
            // if(ps.size() >= 0)
            //     printf("%d %d %d\n", ps.size(), cs.size(), match_id);
        }
        if(ps.size() > cs.size()) {
            ps.pop_back();
            newCode.push_back(WASM_OP_DROP);
        }
    } else {
        while(ps.size() - match_id >= 2) {
            uint8 ta = ps.back();
            ps.pop_back();
            uint8 tb = ps.back();
            ps.pop_back();
            if(ta == tb || ta == 4 || tb == 4) {
                if(ta == 4) ta = tb;
                if(ta == 4) ta = I32;
                AddRandMath(newCode, ta);
                ps.push_back(ta);
            } else {
                newCode.push_back(GenConvert(ta, tb));
                AddRandMath(newCode, tb);
                ps.push_back(tb);
            }
        }
        if(ps.size() > match_id) {
            ps.pop_back();
            newCode.push_back(WASM_OP_DROP);
        }
        while(ps.size() < cs.size()) {
            int id = GetSuitableLocal(cs[ps.size()]);
            if(id != -1) {
                newCode.push_back(WASM_OP_GET_LOCAL);
                writeu32(newCode, id);
            } else {
                switch(cs[ps.size()]) {
                case 0:
                    // i32
                    newCode.push_back(WASM_OP_I32_CONST);
                    writes32(rand(), newCode);
                    break;
                case 1:
                    newCode.push_back(WASM_OP_I64_CONST);
                    writes64(rand(), newCode);
                    break;
                case 2:
                    newCode.push_back(WASM_OP_F32_CONST);
                    for(int i = 0; i < 4; i++)
                        newCode.push_back(rand() & 0xff);
                    break;
                case 3:
                    newCode.push_back(WASM_OP_F64_CONST);
                    for(int i = 0; i < 8; i++)
                        newCode.push_back(rand() & 0xff);
                    break;
                }
            }
            ps.push_back(cs[ps.size()]);
        }
    }
}

void TryAddSplit(vector<uint8>&newCode, vector<uint8>ps, vector<uint8>cs) {
    int newCode_st = newCode.size();
    int split_cnt = 0;
    vector<uint8> code;
    vector<uint8>newPost, newCur;
    vector<pair<int, uint8>>newlocal, newglobal;
    int sid = -1;
    int dis = 1000;
    for(int j = 0; j < 200; j++) {
        int tid = (rand() * 50 + rand() % 50) % splits.size();
        // try to add splits-sid
        newPost.clear();
        newCur.clear();
        code.clear();
        newlocal.clear();
        newglobal.clear();
        if(decoder("/home/unicornt/WASM/WasmSynthesis/splits/" + splits[tid], code, newCur, newPost, newlocal, newglobal) != true)
            continue;
        bool f = true;
        for(auto ls : newlocal) {
            if(GetSuitableLocal(ls.second) == -1) f = false;
        }
        for(auto ls : newglobal) {
            if(GetSuitableGlobal(ls.second) == -1) f = false;
        }
        if(f == true) {
            int ndis = CalcFixDistance(newCur, cs) + CalcFixDistance(newPost, ps);
            if(ndis < dis) {
                dis = ndis;
                sid = tid;
            }
        }
    }
    printf("Minimum distance is %d\n", dis);
    if(sid == -1) {
        // delet this code fragment
    } else {
        // Track the used split
        used_ingredients.push_back(splits[sid]);
        std::cout << "Add split: " << splits[sid] << endl;
        newPost.clear();
        newCur.clear();
        code.clear();
        newlocal.clear();
        newglobal.clear();
        decoder("/home/unicornt/WASM/WasmSynthesis/splits/" + splits[sid], code, newCur, newPost, newlocal, newglobal);
        AddFixCode(newCode, ps, newPost);
        // print("/home/unicornt/WASM/WasmSynthesis/splits/"+splits[sid]);
        split_cnt++;
        // PrintInstr(0, code.size(), code.data());
        debug("===========");
        debug("add split : stack size " << ps.size() << ' ' << newPost.size());
        ps.clear();
        for(auto k : newCur)
            ps.push_back(k);
        TryAddSplitAndFix(code, newCode, newlocal, newglobal);
    }

    AddFixCode(newCode, ps, cs);
    // debug("Match id " << match_id);
    // debug(ps.size() <<  ' ' << cs.size());
    // debug("======= PostStack ========");
    // for(auto k : ps)
    //     cout << +k << ' ';
    // cout << endl;
    // debug("======== CurStack ========");
    // for(auto k : cs)
    //     cout << +k << ' ';
    // cout << endl;
    // debug("==========================");
    // printf("%d %d %d\n", ps.size(), cs.size(), match_id);
    debug("============ what is added =============");
    // PrintInstr(newCode_st, newCode.size(), newCode.data());
    debug("========================================");
}

int isI32OP(uint8 opcode) {
    switch(opcode) {
    case WASM_OP_I32_ADD:
    case WASM_OP_I32_SUB:
    case WASM_OP_I32_MUL:
    case WASM_OP_I32_DIV_S:
    case WASM_OP_I32_DIV_U:
    case WASM_OP_I32_REM_S:
    case WASM_OP_I32_REM_U:
    case WASM_OP_I32_AND:
    case WASM_OP_I32_OR:
    case WASM_OP_I32_XOR:
    case WASM_OP_I32_SHL:
    case WASM_OP_I32_SHR_S:
    case WASM_OP_I32_SHR_U:
    case WASM_OP_I32_ROTL:
    case WASM_OP_I32_ROTR:
        return 1;
    default:
        return 0;
    }
    return 0;
}

int isALoad(uint8 opcode) {
    switch(opcode) {
        case WASM_OP_I32_LOAD:
        case WASM_OP_I32_LOAD8_S:
        case WASM_OP_I32_LOAD8_U:
        case WASM_OP_I32_LOAD16_S:
        case WASM_OP_I32_LOAD16_U:
            return I32;
        case WASM_OP_I64_LOAD:
        case WASM_OP_I64_LOAD8_S:
        case WASM_OP_I64_LOAD8_U:
        case WASM_OP_I64_LOAD16_S:
        case WASM_OP_I64_LOAD16_U:
        case WASM_OP_I64_LOAD32_S:
        case WASM_OP_I64_LOAD32_U:
            return I64;
        case WASM_OP_F32_LOAD:
            return F32;
        case WASM_OP_F64_LOAD:
            return F64;
        /* store */
        case WASM_OP_I32_STORE:
        case WASM_OP_I32_STORE8:
        case WASM_OP_I32_STORE16:
        case WASM_OP_I64_STORE:
        case WASM_OP_I64_STORE8:
        case WASM_OP_I64_STORE16:
        case WASM_OP_I64_STORE32:
        case WASM_OP_F32_STORE:
        case WASM_OP_F64_STORE:
        default:
            return -1;
    }
    return -1;
}

int isAStore(uint8 opcode) {
    switch(opcode) {
        /* store */
        case WASM_OP_I32_STORE:
        case WASM_OP_I32_STORE8:
        case WASM_OP_I32_STORE16:
            return I32;
        case WASM_OP_I64_STORE:
        case WASM_OP_I64_STORE8:
        case WASM_OP_I64_STORE16:
        case WASM_OP_I64_STORE32:
            return I64;
        case WASM_OP_F32_STORE:
            return F32;
        case WASM_OP_F64_STORE:
            return F64;
        case WASM_OP_I32_LOAD:
        case WASM_OP_I32_LOAD8_S:
        case WASM_OP_I32_LOAD8_U:
        case WASM_OP_I32_LOAD16_S:
        case WASM_OP_I32_LOAD16_U:
        case WASM_OP_I64_LOAD:
        case WASM_OP_I64_LOAD8_S:
        case WASM_OP_I64_LOAD8_U:
        case WASM_OP_I64_LOAD16_S:
        case WASM_OP_I64_LOAD16_U:
        case WASM_OP_I64_LOAD32_S:
        case WASM_OP_I64_LOAD32_U:
        case WASM_OP_F32_LOAD:
        case WASM_OP_F64_LOAD:
        default:
            return -1;
    }
    return -1;
}

void TryMutate(int p, int p_end, vector<uint8>&newCode, int mutate_cnt) {
    // int mutate_cnt = (p_end - p) / 100 + 1;
    // bool mutate = mutate_cnt > 0;
    for(int i = p; i < p_end; i++)
        checkInstr[i] = false;
    // PrintInstr(p, p_end);
    GenerateInfo(p, p_end, 0);
    for(int i = p; i < p_end; i++) {
        if(checkInstr[i] == true) {
            bool mutate = false;
            if((rand() % 5 == 0) && i < p_end - 10 && mutate_cnt > 0) {
                // Could start here!
                // vector<int>endVec;
                GenerateInfo(i, p_end, 0);
                for(int kk = 0; kk < 30; kk++){
                    int j = i + rand() % min(p_end - i - 10, 50) + 10;
                    if(checkInstr[j] != true || instrDep[j] != instrDep[i])
                        continue;
                    if(mutate_cnt > 0) {
                        debug("Starting Mutation!!!");
                        // Starting Mutation
                        if(GenerateInfo(i, j) != true) continue;
                        bool f = true;
                        for(auto k : postStack)
                            if(k == TBD) f =false;
                        for(auto k : curStack)
                            if(k == TBD) f = false;
                        if(f == false) continue;
                        mutate_cnt --;
                        //tryAddSplit
                        debug("============================================");
                        // PrintInstr(i, j);
                        printf("Mutate %d %d\n", i, j);
                        for(auto k : postStack)
                            cout << +k << ' ';
                        cout << endl;
                        for(auto k : curStack)
                            cout << +k << ' ';
                        cout << endl;
                        debug("============================================");
                        debug("Split " << i << ' ' << j);
                        reverse(postStack.begin(), postStack.end());
                        TryAddSplit(newCode, postStack, curStack);
                        i = j - 1;
                        mutate = true;
                        debug("Finish Mutataion!!!");
                        // addFinalPrint(newCode);
                        break;
                    }
                }
            }
            if(mutate == false) {
                int type = -1;
                uint8 opcode = wasmBuffer[i];
                newCode.push_back(opcode);
                if((type=isAStore(opcode)) != -1) {
                    // cout << "Is a store" << endl;
                    GenPreMem(newCode, opcode, (uint8)type);
                    int pn = i + 1;
                    readu32(pn, wasmBuffer);
                    readu32(pn, wasmBuffer);
                    for(int w = i + 1; w < pn; w++)
                        newCode.push_back(wasmBuffer[w]);
                    i = pn - 1;
                } else if((type = isALoad(opcode) != -1)) {
                    // cout << "Is a load" << endl;
                    newCode.pop_back();
                    newCode.push_back(WASM_OP_I32_CONST);
                    writes32(MEM_LIM, newCode);
                    newCode.push_back(WASM_OP_I32_AND);
                    int pn = i + 1;
                    readu32(pn, wasmBuffer);
                    readu32(pn, wasmBuffer);
                    for(int w = i; w < pn; w++)
                        newCode.push_back(wasmBuffer[w]);
                    i = pn - 1;
                } else if(opcode == WASM_OP_CALL_INDIRECT) {
                    int p = i + 1;
                    uint32 type = readu32(p, wasmBuffer);
                    uint32 table_idx = readu32(p, wasmBuffer);
                    // printf("Fix Call Indirect %u %u\n", table_idx, type);
                    newCode.pop_back();
                    vector<int>suitFunc;
                    for(auto f : funcRefTable[table_idx])
                        if(FuncType[f] == type)
                            suitFunc.push_back(f);
                    if(suitFunc.size() == 0) {
                        // addCallPrint(newCode);
                        newCode.push_back(WASM_OP_DROP);
                        vector<uint8>pre, post, empty;
                        for(auto p : TypeInfo[type])
                            pre.push_back(p);
                        for(auto p : TypeInfoRet[type])
                            post.push_back(p);
                        AddFixCode(newCode, pre, empty);
                        AddFixCode(newCode, empty, post);
                    }
                    else {
                        newCode.push_back(WASM_OP_DROP);
                        newCode.push_back(WASM_OP_CALL);
                        writeu32(newCode, (uint32)suitFunc[0]);
                    }
                    i = p - 1;
                } else if (isI32OP(opcode)) {
                    addCallPrint(newCode);
                } else if (opcode == WASM_OP_CALL) {
                    int p = i + 1;
                    uint32 id = readu32(p, wasmBuffer);
                    if(id == 5u) {
                        newCode.pop_back();
                        newCode.push_back(WASM_OP_I32_CONST);
                        writes32(65520, newCode);
                        newCode.push_back(WASM_OP_SET_GLOBAL);
                        writeu32(newCode, 0);
                        newCode.push_back(opcode);
                    }
                } else if (opcode == WASM_OP_BR_IF) {
                    newCode.pop_back(); 
                    int id = GetSuitableLocal(I32);
                    if(id != -1) {
                        newCode.push_back(WASM_OP_GET_LOCAL);
                        writeu32(newCode, (uint)id);
                        newCode.push_back(WASM_OP_GET_LOCAL);
                        writeu32(newCode, (uint)id);
                        addI32Const(newCode, 1);
                        newCode.push_back(WASM_OP_I32_ADD);
                        newCode.push_back(WASM_OP_SET_LOCAL);
                        writeu32(newCode, (uint)id);
                        addI32Const(newCode, 0xffff);
                        newCode.push_back(WASM_OP_I32_AND);
                        addI32Const(newCode, 0xffff);
                        if(rand() % 2 == 0)
                            newCode.push_back(WASM_OP_I32_EQ);
                        else
                            newCode.push_back(WASM_OP_I32_NE);
                        newCode.push_back(WASM_OP_I32_AND);
                    }
                    newCode.push_back(opcode);
                }
            }
        } else {
            newCode.push_back(wasmBuffer[i]);
        }
    }
}

void SimpleMutate(int p, int p_end, vector<uint8>&newCode) {
    for(int i = p; i < p_end; i++)
        checkInstr[i] = false;
    GenerateInfo(p, p_end, 0);
    for(int i = p; i < p_end; i++) {
        if(checkInstr[i] == true) {
            uint8 opcode = wasmBuffer[i];
            if(isI32OP(opcode)) {
                printf("mutate op\n");
                AddRandMath(newCode, 0);
            } else newCode.push_back(opcode);
        } else {
            newCode.push_back(wasmBuffer[i]);
        }
    }
}

void loadSplits(string dir) {
    namespace fs = std::filesystem;
    if (fs::is_directory(dir)) {
        for (const auto& entry : fs::directory_iterator(dir)) {
            if (entry.is_regular_file()) {
                splits.push_back(entry.path().filename());
            }
        }
    } else {
        std::cerr << "Invalid directory path." << std::endl;
    }
    std::cout << "Load Splits " << splits.size() << endl;
}

int main(int argc, char *argv[]) {
    // ensure our global manifest exists
    {
    std::ifstream init("all_traces.json");
    if (!init.good()) {
        std::ofstream create("all_traces.json");
        create << "[\n]\n";
    }
    }
    srand(time(NULL));
    if(argc == 4 || argc == 5) {
        if(strcmp(argv[1], "split") == 0) {
            SplitMod = true;
        } else if(strcmp(argv[1], "mutation") == 0) {
            MutationMod = true;
            if(argc == 3) {
                printf("Please input target file\n");
                return 1;
            }
        } else if(strcmp(argv[1], "simplemutation") == 0) {
            SimpleMutationMod = true;
            MutationMod = true;
        } else {
            printf("Wrong Mode Selected\n");
            return 1;
        }

        if(MutationMod == true && SimpleMutationMod != true) {
            loadSplits(argv[2]);
        }
        split_file = argv[3];
        seed_file = argv[3]; // Set seed_file to input WASM file
        string fname(argv[3]);
        FILE *wasmFile = fopen(argv[3], "rb");
        if(wasmFile == NULL) {
            printf("Cannot open wasm file\n");
            log_file.close();
            return 1;
        }
        int wasmSize = fread(wasmBuffer, sizeof(uint8), sizeof(wasmBuffer), wasmFile);
        fclose(wasmFile);
        // printf("File Size %d\n", wasmSize);
        uint8 *buffer = wasmBuffer;
        int pos = 8;
        vector<uint8>newCode;
        for(int i = 0; i < 8; i++)
            newCode.push_back(buffer[i]);
        vector<uint8>newTypeSec, newImportSec, newFuncSec, newTableSec, newMemSec, newGlobSec, newExportSec, newStartSec, newElemSec, newCodeSec, newDataSec;
        int TypeCnt, ImportCnt, FuncCnt, TableCnt, MemCnt, GlobCnt, ExportCnt, StartExist, ElemCnt, CodeCnt, DataCnt;
        if(wasmBuffer[0] != 0 || wasmBuffer[1] != 'a' || wasmBuffer[2] != 's' || wasmBuffer[3] != 'm') {
            printf("Wrong Wasm Head\n");
            log_file.close();
            return 1;
        }
        while(pos < wasmSize) {
            uint8 secID = buffer[pos++];
            // cout << hex << +secID << endl;
            uint32 secSize = readu32(pos, buffer);
            int sec_end = pos + secSize;
            // printf("Sec %u Size %u\n", secID, secSize);
            switch (secID) {
                case 1: // type section
                {
                    TypeCnt = readu32(pos, buffer);
                    // printf("Type Cnt %d\n", TypeCnt);
                    for(int i = 0; i < TypeCnt; i++) {
                        uint8 f = buffer[pos++];
                        assert(f == 0x60);
                        uint32 params = readu32(pos, buffer);
                        for(uint j = 0; j < params; j++)
                            TypeInfo[i].push_back(buffer[pos++]);
                        uint32 results = readu32(pos, buffer);
                        for(uint j = 0; j < results; j++)
                            TypeInfoRet[i].push_back(buffer[pos++]);
                    }
                    for(int i = pos - secSize; i < sec_end; i++)
                        newTypeSec.push_back(buffer[i]);
                    pos = sec_end;
                    break;
                }
                case 2: // import section
                {
                    ImportCnt = readu32(pos, buffer);
                    import_cnt = ImportCnt;
                    // printf("Import Cnt %d\n", ImportCnt);
                    for(int i = pos; i < sec_end; i++)
                        newImportSec.push_back(buffer[i]);
                    pos = sec_end;
                    break;
                }
                case 3: // function section
                {
                    FuncCnt = readu32(pos, buffer);
                    // printf("Func Cnt %d\n", FuncCnt);
                    for(int i = 0; i < FuncCnt; i++)
                        FuncType.push_back(readu32(pos, buffer));
                    for(int i = pos - secSize; i < sec_end; i++)
                        newFuncSec.push_back(buffer[i]);
                    pos = sec_end;
                    break;
                }
                case 4: // Table section
                {
                    TableCnt = readu32(pos, buffer);
                    for(int i = pos; i < sec_end; i++)
                        newTableSec.push_back(buffer[i]);
                    pos = sec_end;
                    break;
                }
                case 5: // Mem section
                {
                    MemCnt = readu32(pos, buffer);
                    for(int i = pos; i < sec_end; i++)
                        newMemSec.push_back(buffer[i]);
                    pos = sec_end;
                    break;
                }
                case 6: // global section
                {
                    GlobCnt = readu32(pos, buffer);
                    // printf("Global Cnt %d\n", GlobCnt);
                    for(int i = 0; i < GlobCnt; i++) {
                        uint8 type = buffer[pos++];
                        uint8 mut = buffer[pos++];
                        LoadInitExpr(pos, sec_end, buffer);
                        // printf("Global Type %u mut %u\n", type, mut);
                        Globals.push_back(make_pair(type, mut));
                    }
                    for(int i = pos - secSize; i < sec_end; i++)
                        newGlobSec.push_back(buffer[i]);
                    pos = sec_end;
                    break;
                }
                case 7: // export section
                {
                    ExportCnt = readu32(pos, buffer);
                    for(int i = pos; i < sec_end; i++)
                        newExportSec.push_back(buffer[i]);
                    pos = sec_end;
                    break;
                }
                case 8: // start section
                {
                    StartExist = 1;
                    for(int i = pos; i < sec_end; i++)
                        newStartSec.push_back(buffer[i]);
                    pos = sec_end;
                    break;
                }
                case 9: // element section
                {
                    ElemCnt = readu32(pos, buffer);
                    // printf("Element Cnt %d\n", ElemCnt);
                    for(int i = 0; i < ElemCnt; i++) {
                        uint32 table_idx = readu32(pos, buffer);
                        LoadInitExpr(pos, sec_end, buffer);
                        uint32 elem_cnt = readu32(pos, buffer);
                        // printf("Table %u elem cnt %u\n", table_idx, elem_cnt);
                        for(int j = 0; j < elem_cnt; j++) {
                            funcRefTable[table_idx].push_back(readu32(pos, buffer));
                        }
                    }
                    for(int i = pos - secSize; i < sec_end; i++)
                        newElemSec.push_back(buffer[i]);
                    pos = sec_end;
                    break;
                }
                case 10: // code section
                {
                    CodeCnt = readu32(pos, buffer);
                    // printf("Code Cnt %d\n", CodeCnt);
                    int code_start = newCode.size();
                    for(int i = 0; i < CodeCnt; i++) {
                        uint32 codeSize = readu32(pos, buffer);
                        // printf("Code %d Size %u\n", i, codeSize);
                        int code_end = pos + codeSize;
                        int local_tot = readu32(pos, buffer);
                        // printf("Local Tot %d\n", local_tot);
                        Locals.clear();
                        for(int j = 0; j < local_tot; j++) {
                            int local_cnt = readu32(pos, buffer);
                            uint8 local_type = buffer[pos++];
                            // printf("Local %d Type %u\n", local_cnt, local_type);
                            Locals.push_back(make_pair(local_cnt, local_type));
                        }
                        int code_body = pos;
                        if(SplitMod == true)
                            TrySplit(code_body, code_end, argv[3]);
                        else if(SimpleMutationMod == true)
                            SimpleMutate(code_body, code_end, newCodeSec);
                        else TryMutate(code_body, code_end, newCodeSec, 3);
                        pos = code_end;
                    }
                    pos = sec_end;
                    break;
                }
                case 11: // data section
                {
                    DataCnt = readu32(pos, buffer);
                    for(int i = pos; i < sec_end; i++)
                        newDataSec.push_back(buffer[i]);
                    pos = sec_end;
                    break;
                }
                default:
                    printf("Unknown Section\n");
                    log_file.close();
                    return 1;
            }
        }
        // printf("File Size %d\n", wasmSize);
        for(auto x : newTypeSec)
            newCode.push_back(x);
        for(auto x : newImportSec)
            newCode.push_back(x);
        for(auto x : newFuncSec)
            newCode.push_back(x);
        for(auto x : newTableSec)
            newCode.push_back(x);
        for(auto x : newMemSec)
            newCode.push_back(x);
        for(auto x : newGlobSec)
            newCode.push_back(x);
        for(auto x : newExportSec)
            newCode.push_back(x);
        for(auto x : newStartSec)
            newCode.push_back(x);
        for(auto x : newElemSec)
            newCode.push_back(x);
        int codeSecStart = newCode.size();
        int codeSecSize = newCodeSec.size();
        newCode.push_back(0x0a);
        writeu32(newCode, codeSecSize + 4);
        for(auto x : newCodeSec)
            newCode.push_back(x);
        for(auto x : newDataSec)
            newCode.push_back(x);
        string out_file;
        if(argc == 5)
            out_file = argv[4];
        else out_file = fname.substr(0, fname.find_last_of('.')) + "-O0.wasm";
        FILE *wasmOut = fopen(out_file.c_str(), "wb");
        if(wasmOut == NULL) {
            printf("Cannot open output file\n");
            log_file.close();
            return 1;
        }
        fwrite(newCode.data(), sizeof(uint8), newCode.size(), wasmOut);
        fclose(wasmOut);
        // ------------------------------------------------
        // Logging added
        // ------------------------------------------------
    {
        using fs = std::filesystem::path;
            std::string testcase = fs(seed_file).stem().string();

        // open for read+write
        std::fstream manifest("all_traces.json",
                              std::ios::in | std::ios::out);
        if (!manifest) {
            std::cerr << "ERROR: cannot open all_traces.json\n";
            return 1;
        }

        // figure out if this is the first entry
        manifest.seekg(0, std::ios::end);
        auto size = manifest.tellg();
        bool first = (size <= 4);        // file is "[\n]\n" if empty

        // rewind write‐cursor to just before the closing "]\n"
        manifest.seekp(-2, std::ios::end);

        // if not first, prepend a comma
        if (!first) manifest << ",\n";

        // write our object
        manifest << "  {\n";
        manifest << "    \"testcase\":   \"" << out_file << "\",\n";
        manifest << "    \"seed\":       \"" << seed_file << "\",\n";
        manifest << "    \"ingredients\": [\n";
        for (size_t i = 0; i < used_ingredients.size(); ++i) {
            // splitName is e.g. "split-ece4b78b"
            const auto &splitName = used_ingredients[i];

            // if your splits live in argv[2], build the full path:
            std::filesystem::path splitsDir{argv[2]};
            std::string splitPath = (splitsDir / splitName).string();

            // read the last line out of that file, pull its filename:
            std::string origin = extractOriginName(splitPath);

            manifest << "      {\"" << splitName << "\": \"" << origin << "\"}"
                     << (i + 1 < used_ingredients.size() ? "," : "")
                     << "\n";
        }
        manifest << "    ]\n";

        manifest << "  }\n";

        // finally close the JSON array
        manifest << "]\n";
        manifest.close();
    }


    }
    return 0;
}
