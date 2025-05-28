(module
  (type (;0;) (func (param i64) (result i64)))
  (func (;0;) (type 0) (param i64) (result i64)
    f64.const 0x1.1d674b424039ap-283 (;=7.17349e-86;)
    memory.size
    i32.load16_u offset=758165
    i64.load16_s offset=769359
    br 0 (;@0;)
    i64.trunc_f64_s
    f64.const -0x1.6b44142007e6ep-958 (;=-5.82437e-289;)
    memory.size
    if (result i32)  ;; label = @1
      f32.const -0x1.306feep+6 (;=-76.1093;)
      f32.abs
      memory.size
      i32.extend16_s
      i32.const -1994756476
      i32.store8 offset=274737
      i32.const 161486051
      br 0 (;@1;)
      i64.trunc_sat_f32_u
      global.get 0
      i64.reinterpret_f64
      global.get 1
      i64.xor
      global.set 1
      global.get 2
      i64.xor
      global.set 2
      i32.const 45984448
    else
      i32.const 1569193785
    end
    global.get 3
    i32.xor
    global.set 3
    i64.reinterpret_f64
    global.get 1
    i64.xor
    global.set 1)
  (func (;1;) (type 0) (param i64) (result i64)
    f32.const -0x1.454bf8p+111 (;=-3.2989e+33;)
    f32.const -0x1.a7bff2p-125 (;=-3.89153e-38;)
    f32.mul
    global.get 0
    f32.demote_f64
    i32.const -994208507
    f32.load offset=292905 align=1
    block (result i64)  ;; label = @1
      i32.const 431404148
      i64.load32_s offset=452379
      i64.popcnt
      call 1
      local.tee 0
      block  ;; label = @2
        br 0 (;@2;)
        memory.size
        f32.convert_i32_u
        f32.const -0x1.4c6198p-98 (;=-4.09691e-30;)
        br 0 (;@2;)
        i64.trunc_f32_u
        i32.const -135284978
        i64.load16_s offset=731035
        f32.convert_i64_s
        i32.reinterpret_f32
        i32.load16_s offset=500487
        if (param i64) (result i64)  ;; label = @3
          i64.extend8_s
          local.get 0
          f64.const -0x1.3a90511721526p-645 (;=-8.41631e-195;)
          i32.trunc_f64_u
          memory.grow
          i64.load32_s offset=273730
          i64.add
          i64.rotr
          local.set 0
          memory.size
          f32.convert_i32_s
          local.get 0
          block (result f32)  ;; label = @4
            local.get 0
            local.tee 0
            local.tee 0
            global.get 0
            i64.trunc_sat_f64_s
            i64.shl
            local.set 0
            block  ;; label = @5
              local.get 0
              i64.extend16_s
              i64.extend16_s
              loop  ;; label = @6
                br 0 (;@6;)
                global.get 0
                memory.size
                i32.popcnt
                i64.load8_u offset=1034214
                memory.size
                br 1 (;@5;)
                i32.load16_u offset=753120 align=1
                i64.load8_u offset=717919
                i64.popcnt
                i64.rem_s
                i32.const -1717731790
                br 0 (;@6;)
                i64.const -6238712503609193101
                br 5 (;@1;)
                block (result i64)  ;; label = @7
                  local.get 0
                  global.get 0
                  local.get 0
                  local.get 0
                  memory.size
                  i32.load8_s offset=33780
                  i32.ctz
                  if (param i64) (result i64)  ;; label = @8
                    i64.const -5417754218675688832
                    i64.popcnt
                    i64.ge_u
                    i64.load8_s offset=428168
                    f32.convert_i64_s
                    i32.trunc_f32_u
                    i32.eqz
                    br_table 2 (;@6;) 3 (;@5;) 6 (;@2;) 3 (;@5;)
                    block  ;; label = @9
                      loop (result f32)  ;; label = @10
                        i64.const 2657249739369608460
                        i64.clz
                        local.set 0
                        loop (result f32)  ;; label = @11
                          local.get 0
                          f32.const 0x1.731a8cp+69 (;=8.55707e+20;)
                          f32.floor
                          f32.nearest
                          f32.floor
                          f32.floor
                          br 0 (;@11;)
                          i32.trunc_sat_f32_s
                          i32.load8_u offset=980445
                          i64.load16_u offset=694106
                          local.set 0
                          i32.wrap_i64
                          i64.extend_i32_u
                          br 6 (;@5;)
                          i32.wrap_i64
                          i32.load16_s offset=3644981659
                          i32.load offset=705168 align=1
                          i64.load8_u offset=919088
                          i32.const 1905265127
                          i32.extend8_s
                          i32.const 800170931
                          i32.store16 offset=945834
                          f32.const 0x1.f59722p-74 (;=1.03726e-22;)
                          i32.const 1616082298
                          i32.load8_s offset=271108
                          local.get 0
                          f32.convert_i64_s
                          i64.trunc_f32_s
                          i32.const 1113348967
                          i32.extend16_s
                          i64.load offset=2474969051 align=1
                          i64.le_u
                          i32.div_u
                          i32.load offset=290665 align=1
                          i64.load16_u offset=1393282972
                          i32.wrap_i64
                          i32.extend8_s
                          i32.const -1170668004
                          f64.convert_i32_s
                          i64.trunc_f64_u
                          i64.store offset=258656 align=2
                          loop (result f32)  ;; label = @12
                            block  ;; label = @13
                            end
                            loop  ;; label = @13
                              local.get 0
                              f64.convert_i64_u
                              f64.ceil
                              i32.trunc_sat_f64_s
                              i32.load16_s offset=241225 align=1
                              br_if 3 (;@10;)
                              memory.size
                              f32.const -0x1.202252p+102 (;=-5.70708e+30;)
                              memory.size
                              i32.load16_u offset=664716
                              i32.load16_s offset=111316
                              i64.load32_s offset=885372 align=1
                              block  ;; label = @14
                                f64.const 0x1.c0301c96022a2p-1021 (;=7.79103e-308;)
                                f64.ceil
                                i64.trunc_f64_u
                                f64.const -0x1.b798991db344cp+868 (;=-3.37948e+261;)
                                i32.trunc_f64_u
                                i32.load8_s offset=558398
                                i64.load8_u offset=823864
                                i64.sub
                                i64.extend16_s
                                i32.const -1766884117
                                memory.size
                                memory.grow
                                f32.load offset=846582 align=1
                                f32.trunc
                                i32.trunc_f32_u
                                f32.convert_i32_s
                                f32.const -0x1.c11314p+103 (;=-1.77897e+31;)
                                f32.const 0x1.699216p-116 (;=1.7001e-35;)
                                f32.lt
                                loop  ;; label = @15
                                  f32.const -0x1.245d78p+49 (;=-6.42918e+14;)
                                  i64.trunc_f32_s
                                  f32.const -0x1.af099p+35 (;=-5.78529e+10;)
                                  block (result f64)  ;; label = @16
                                    local.get 0
                                    i64.ctz
                                    i32.wrap_i64
                                    f64.const 0x1.c4ec4b03828cdp-447 (;=4.86829e-135;)
                                    f64.floor
                                    f32.demote_f64
                                    f32.trunc
                                    global.get 0
                                    f64.neg
                                    block (result i64)  ;; label = @17
                                      block  ;; label = @18
                                        block (result i32)  ;; label = @19
                                          br 5 (;@14;)
                                          block  ;; label = @20
                                          end
                                          local.get 0
                                          f32.const 0x1.696446p+82 (;=6.8265e+24;)
                                          f32.sqrt
                                          i32.trunc_f32_s
                                          i32.load offset=253492
                                          i32.load8_s offset=217664
                                          i64.extend_i32_s
                                          f64.convert_i64_u
                                          i64.trunc_sat_f64_s
                                          i64.add
                                          block (result i64)  ;; label = @20
                                            loop  ;; label = @21
                                              i32.const -1498710640
                                              i64.load32_u offset=274122 align=1
                                              br 18 (;@3;)
                                              f64.const 0x1.fb7bd9a2e0f6dp+591 (;=1.60661e+178;)
                                              memory.size
                                              i64.load8_u offset=1028530
                                              local.get 0
                                              local.get 0
                                              local.tee 0
                                              global.get 0
                                              i32.const 1476603559
                                              i64.extend_i32_s
                                              i64.extend16_s
                                              nop
                                              local.tee 0
                                              i64.eqz
                                              i64.load8_s offset=671359
                                              i64.const -4621611456961985054
                                              f64.reinterpret_i64
                                              i64.trunc_f64_s
                                              br 9 (;@12;)
                                              i32.wrap_i64
                                              i64.load16_u offset=940793 align=1
                                              f64.convert_i64_u
                                              f32.const 0x1.d26ca4p+83 (;=1.7621e+25;)
                                              i32.trunc_f32_u
                                              i32.extend8_s
                                              i64.load16_s offset=733107
                                              call 4
                                              br 14 (;@7;)
                                              loop  ;; label = @22
                                                i64.const -5330522060474223880
                                                i32.const 1432964627
                                                f64.load offset=743970 align=1
                                                local.get 0
                                                local.set 0
                                                i32.trunc_sat_f64_s
                                                br_table 0 (;@22;) 1 (;@21;) 4 (;@18;) 7 (;@15;) 8 (;@14;) 9 (;@13;) 10 (;@12;) 11 (;@11;) 12 (;@10;) 13 (;@9;) 16 (;@6;) 17 (;@5;) 20 (;@2;) 9 (;@13;)
                                                call 0
                                                f64.const -0x1.4354c0241d9b6p-544 (;=-2.19326e-164;)
                                                i64.const 8733583981299093434
                                                i64.extend32_s
                                                memory.size
                                                global.get 0
                                                i32.trunc_sat_f64_u
                                                f64.convert_i32_s
                                                f32.demote_f64
                                                i64.trunc_f32_s
                                                br 9 (;@13;)
                                                global.get 0
                                                i32.trunc_f64_u
                                                f32.load offset=841012 align=2
                                                f32.trunc
                                                i64.const 5076352250387181456
                                                f64.convert_i64_u
                                                f64.floor
                                                i32.trunc_sat_f64_s
                                                i32.load16_u offset=766036 align=1
                                                memory.size
                                                i32.rem_s
                                                br 16 (;@6;)
                                                global.get 0
                                                global.set 0
                                                f32.load offset=716437 align=1
                                                f32.ge
                                                f32.convert_i32_s
                                                f32.abs
                                                i32.const 1493280705
                                                i32.load8_u offset=1088869171
                                                i64.load32_s offset=2252006257 align=1
                                                block (result f32)  ;; label = @23
                                                  memory.size
                                                  i32.extend16_s
                                                  f32.load offset=955587 align=2
                                                  f32.sqrt
                                                  f32.const -0x1.c26ae4p-98 (;=-5.55182e-30;)
                                                  block (result i64)  ;; label = @24
                                                    block  ;; label = @25
                                                      i64.const -5313460675979594573
                                                      i64.extend8_s
                                                      local.set 0
                                                      br 11 (;@14;)
                                                      local.get 0
                                                      f64.reinterpret_i64
                                                      f64.const 0x1.611eddaed89a7p+145 (;=6.15223e+43;)
                                                      f64.min
                                                      i32.trunc_sat_f64_s
                                                      f32.convert_i32_u
                                                      i32.trunc_f32_s
                                                      i64.load32_u offset=87412
                                                      local.tee 0
                                                      br 14 (;@11;)
                                                      i32.const -775353947
                                                      block (result i32)  ;; label = @26
                                                        i64.const -1288708890157453888
                                                        f32.const 0x1.5e284ap+73 (;=1.29185e+22;)
                                                        i32.trunc_sat_f32_u
                                                        br_if 9 (;@17;)
                                                        local.tee 0
                                                        local.get 0
                                                        br 18 (;@8;)
                                                        memory.size
                                                        i64.load8_s offset=3850441502
                                                        local.tee 0
                                                        i64.mul
                                                        f32.convert_i64_u
                                                        global.get 0
                                                        local.get 0
                                                        f32.convert_i64_u
                                                        i32.reinterpret_f32
                                                        br_table 1 (;@25;) 4 (;@22;) 5 (;@21;) 8 (;@18;) 11 (;@15;) 12 (;@14;) 13 (;@13;) 14 (;@12;) 15 (;@11;) 16 (;@10;) 17 (;@9;) 20 (;@6;) 21 (;@5;) 24 (;@2;) 24 (;@2;)
                                                        global.set 0
                                                        f32.const -0x1.eead32p+51 (;=-4.35122e+15;)
                                                        f32.abs
                                                        i32.trunc_f32_u
                                                        local.get 0
                                                        i64.eqz
                                                        i32.ctz
                                                        i32.rem_u
                                                        i64.const -7115023560440277565
                                                        i64.store16 offset=298356
                                                        f64.const -0x1.6044fbd0a3e6bp-788 (;=-8.45276e-238;)
                                                        f64.abs
                                                        i32.trunc_f64_s
                                                        global.get 3
                                                        i32.xor
                                                        global.set 3
                                                        i32.reinterpret_f32
                                                        global.get 4
                                                        i32.xor
                                                        global.set 4
                                                        i32.const -801007472
                                                      end
                                                      global.get 3
                                                      i32.xor
                                                      global.set 3
                                                      global.get 3
                                                      i32.xor
                                                      global.set 3
                                                      global.get 2
                                                      i64.xor
                                                      global.set 2
                                                    end
                                                    i64.const -6884851442731476456
                                                  end
                                                  global.get 2
                                                  i64.xor
                                                  global.set 2
                                                  i32.reinterpret_f32
                                                  global.get 4
                                                  i32.xor
                                                  global.set 4
                                                end
                                                i32.reinterpret_f32
                                                global.get 4
                                                i32.xor
                                                global.set 4
                                                global.get 2
                                                i64.xor
                                                global.set 2
                                                i32.reinterpret_f32
                                                global.get 4
                                                i32.xor
                                                global.set 4
                                                drop
                                                global.get 3
                                                i32.xor
                                                global.set 3
                                                global.get 2
                                                i64.xor
                                                global.set 2
                                                i64.reinterpret_f64
                                                global.get 1
                                                i64.xor
                                                global.set 1
                                                global.get 2
                                                i64.xor
                                                global.set 2
                                              end
                                              i64.reinterpret_f64
                                              global.get 1
                                              i64.xor
                                              global.set 1
                                              global.get 2
                                              i64.xor
                                              global.set 2
                                              i64.reinterpret_f64
                                              global.get 1
                                              i64.xor
                                              global.set 1
                                              global.get 2
                                              i64.xor
                                              global.set 2
                                              global.get 2
                                              i64.xor
                                              global.set 2
                                              global.get 2
                                              i64.xor
                                              global.set 2
                                              i64.reinterpret_f64
                                              global.get 1
                                              i64.xor
                                              global.set 1
                                            end
                                            i64.const -5896264625713561550
                                          end
                                          global.get 2
                                          i64.xor
                                          global.set 2
                                          global.get 2
                                          i64.xor
                                          global.set 2
                                          i32.const -1355946179
                                        end
                                        global.get 3
                                        i32.xor
                                        global.set 3
                                      end
                                      i64.const 5973994126582624981
                                    end
                                    global.get 2
                                    i64.xor
                                    global.set 2
                                    i64.reinterpret_f64
                                    global.get 1
                                    i64.xor
                                    global.set 1
                                    i32.reinterpret_f32
                                    global.get 4
                                    i32.xor
                                    global.set 4
                                    global.get 3
                                    i32.xor
                                    global.set 3
                                    f64.const -0x1.c921e5886df36p-486 (;=-8.93767e-147;)
                                  end
                                  i64.reinterpret_f64
                                  global.get 1
                                  i64.xor
                                  global.set 1
                                  i32.reinterpret_f32
                                  global.get 4
                                  i32.xor
                                  global.set 4
                                  global.get 2
                                  i64.xor
                                  global.set 2
                                end
                                global.get 3
                                i32.xor
                                global.set 3
                                i32.reinterpret_f32
                                global.get 4
                                i32.xor
                                global.set 4
                                global.get 3
                                i32.xor
                                global.set 3
                                global.get 2
                                i64.xor
                                global.set 2
                              end
                              global.get 2
                              i64.xor
                              global.set 2
                              i32.reinterpret_f32
                              global.get 4
                              i32.xor
                              global.set 4
                              global.get 3
                              i32.xor
                              global.set 3
                            end
                            f32.const -0x1.a91f9cp+102 (;=-8.42044e+30;)
                          end
                          i32.reinterpret_f32
                          global.get 4
                          i32.xor
                          global.set 4
                          i32.reinterpret_f32
                          global.get 4
                          i32.xor
                          global.set 4
                          global.get 2
                          i64.xor
                          global.set 2
                          f32.const 0x1.5255d2p+34 (;=2.27053e+10;)
                        end
                      end
                      i32.reinterpret_f32
                      global.get 4
                      i32.xor
                      global.set 4
                    end
                    i64.const -8940421105919877678
                  end
                  global.get 2
                  i64.xor
                  global.set 2
                  global.get 2
                  i64.xor
                  global.set 2
                  i64.reinterpret_f64
                  global.get 1
                  i64.xor
                  global.set 1
                end
                global.get 2
                i64.xor
                global.set 2
                global.get 3
                i32.xor
                global.set 3
                global.get 2
                i64.xor
                global.set 2
                i64.reinterpret_f64
                global.get 1
                i64.xor
                global.set 1
              end
              global.get 2
              i64.xor
              global.set 2
            end
            f32.const -0x1.48ebf8p-65 (;=-3.48259e-20;)
          end
          i32.reinterpret_f32
          global.get 4
          i32.xor
          global.set 4
          global.get 2
          i64.xor
          global.set 2
          i32.reinterpret_f32
          global.get 4
          i32.xor
          global.set 4
          i64.const 8648349011248235868
        end
        global.get 2
        i64.xor
        global.set 2
        i32.reinterpret_f32
        global.get 4
        i32.xor
        global.set 4
      end
    end
    global.get 2
    i64.xor
    global.set 2
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4
    i64.const -8648936869126115233)
  (func (;2;) (type 0) (param i64) (result i64)
    (local f32 i32 f64)
    i64.const -5332325127996772482
    f32.const -0x1.85c81cp-10 (;=-0.0014869;)
    i64.const 5601960257630694341
    i64.extend32_s
    i64.const 7663628978908725275
    i64.extend16_s
    block (param i64) (result i64)  ;; label = @1
      call 2
    end
    local.get 0
    f32.convert_i64_s
    nop
    memory.size
    i64.const 8171211166429062610
    global.get 0
    f64.sqrt
    i64.trunc_sat_f64_u
    i64.extend16_s
    global.get 0
    f32.const 0x1.06dbf2p-30 (;=9.56276e-10;)
    i64.trunc_sat_f32_s
    local.get 1
    f32.nearest
    f64.promote_f32
    f64.neg
    global.get 0
    f64.add
    local.set 3
    i64.extend8_s
    global.get 0
    f32.const 0x1.963b8ep+89 (;=9.8221e+26;)
    f32.const 0x1.5feffcp-51 (;=6.10514e-16;)
    f32.min
    f32.abs
    i32.const 191669
    if  ;; label = @1
      i64.const 3910165842074232096
      local.tee 0
      local.get 0
      call 5
      i64.rotr
      i64.const -2093187911873024478
      memory.size
      i32.load offset=879320 align=2
      i64.extend_i32_s
      global.get 2
      i64.xor
      global.set 2
      i64.ne
      i32.load8_u offset=454067
      i32.load8_u offset=109168
      i32.load8_s offset=952875
      block (result i32)  ;; label = @2
        local.get 2
        f32.reinterpret_i32
        loop  ;; label = @3
          block  ;; label = @4
            f64.const 0x1.b44f078a79cd5p-361 (;=3.62849e-109;)
            f64.trunc
            loop (result i32)  ;; label = @5
              f64.const -0x1.551f805e2bbep+395 (;=-1.07527e+119;)
              f64.ceil
              i32.trunc_sat_f64_u
              i64.load8_s offset=211776
              i64.clz
              f64.const 0x1.c0543cba7338ep+751 (;=2.07436e+226;)
              loop  ;; label = @6
                loop  ;; label = @7
                  global.get 0
                  i64.trunc_sat_f64_s
                  f32.convert_i64_u
                  local.tee 1
                  f64.const -0x1.f9056e9fabap-366 (;=-1.31248e-110;)
                  block  ;; label = @8
                    i32.const -1345088978
                    br_table 0 (;@8;) 1 (;@7;) 2 (;@6;) 3 (;@5;) 4 (;@4;) 5 (;@3;) 7 (;@1;) 7 (;@1;)
                    f32.const -0x1.39fa08p+27 (;=-1.64614e+08;)
                    i32.const -1533699699
                    local.set 2
                    local.get 0
                    memory.size
                    i32.load16_u offset=3096730357
                    memory.size
                    i32.rem_s
                    i32.eqz
                    block  ;; label = @9
                      memory.size
                      i32.load16_u offset=293341
                      f32.load offset=360021 align=1
                      f32.neg
                      f32.const -0x1.9cc2a8p+53 (;=-1.45227e+16;)
                      local.tee 1
                      local.get 1
                      nop
                      f32.trunc
                      f32.neg
                      block (result f32)  ;; label = @10
                        i64.const -8100608559856665131
                        memory.size
                        i64.load32_u offset=793014
                        loop (param i64) (result i64)  ;; label = @11
                          i64.extend16_s
                          i32.wrap_i64
                          local.get 1
                          f64.const -0x1.f154ea9fa1dbfp+262 (;=-1.43968e+79;)
                          local.get 2
                          i64.load offset=417620 align=4
                          br 11 (;@0;)
                          f64.floor
                          f64.const -0x1.b63a1ac464bc4p+772 (;=-4.25222e+232;)
                          i32.trunc_f64_u
                          i32.load16_s offset=1003760 align=1
                          i32.load8_u offset=857415
                          i64.load8_u offset=240764
                          br 8 (;@3;)
                          i64.ctz
                          return
                          f32.demote_f64
                          loop (result f32)  ;; label = @12
                            local.get 3
                            nop
                            f32.const 0x1.b2c982p+7 (;=217.394;)
                            i64.trunc_f32_u
                            f64.convert_i64_s
                            f64.min
                            f64.const 0x1.e76b2a41274b4p-970 (;=1.90795e-292;)
                            f64.trunc
                            f64.le
                            i64.load8_u offset=455028
                            local.set 0
                            block  ;; label = @13
                              global.get 0
                              i32.trunc_f64_u
                              loop  ;; label = @14
                                memory.size
                                f64.convert_i32_s
                                f64.neg
                                f64.neg
                                i32.trunc_f64_u
                                local.tee 2
                                if  ;; label = @15
                                  i32.const -197816670
                                  i64.extend_i32_s
                                  nop
                                  f32.const -0x1.7f4846p-125 (;=-3.51989e-38;)
                                  global.get 0
                                  f32.demote_f64
                                  nop
                                  i32.trunc_f32_u
                                  br_if 0 (;@15;)
                                  local.set 1
                                  block  ;; label = @16
                                    loop (result f32)  ;; label = @17
                                      loop  ;; label = @18
                                        f64.const 0x1.fabec227c10c9p+853 (;=1.18887e+257;)
                                        f64.ceil
                                        local.get 3
                                        i64.trunc_f64_u
                                        block  ;; label = @19
                                          f64.const -0x1.9cccced7def47p-639 (;=-7.06859e-193;)
                                          i64.reinterpret_f64
                                          f32.convert_i64_s
                                          f32.sqrt
                                          i32.trunc_sat_f32_u
                                          local.set 2
                                          i64.const -2015689833038419196
                                          i64.const -3097419754808989552
                                          i64.const -88730108250224076
                                          i64.gt_u
                                          i32.load8_u offset=485543
                                          i64.extend_i32_u
                                          i64.gt_u
                                          br_if 4 (;@15;)
                                        end
                                        f32.convert_i64_u
                                        i32.trunc_sat_f32_s
                                        i32.load16_s offset=3763139336 align=1
                                        i64.extend_i32_s
                                        f32.const 0x1.4d457p+83 (;=1.25906e+25;)
                                        global.get 0
                                        memory.size
                                        i32.load offset=3829137106 align=2
                                        br 16 (;@2;)
                                        local.get 0
                                        br 2 (;@16;)
                                        i64.const -252619873397207893
                                        global.get 0
                                        f64.nearest
                                        local.tee 3
                                        i32.trunc_f64_s
                                        i64.load32_s offset=590032
                                        call 6
                                        i64.rotl
                                        i64.sub
                                        block (result f64)  ;; label = @19
                                          global.get 0
                                          block  ;; label = @20
                                            global.get 0
                                            i64.trunc_sat_f64_s
                                            f64.const 0x1.e87166f7e1798p+653 (;=7.13117e+196;)
                                            i64.const -3897217792716030007
                                            f32.convert_i64_s
                                            br 12 (;@8;)
                                            br 12 (;@8;)
                                            f64.promote_f32
                                            f64.ge
                                            if (param i64) (result i64)  ;; label = @21
                                              block  ;; label = @22
                                                global.get 0
                                                block  ;; label = @23
                                                  memory.size
                                                  i32.ctz
                                                  i32.load16_u offset=3893461351
                                                  f32.load offset=432872283
                                                  i64.const 1342088921170883035
                                                  f64.convert_i64_s
                                                  i64.trunc_f64_u
                                                  memory.size
                                                  local.tee 2
                                                  i64.load8_u offset=445105
                                                  i64.lt_s
                                                  i64.load8_u offset=2071651999
                                                  f32.const -0x1.c30492p+58 (;=-5.07801e+17;)
                                                  block (result i32)  ;; label = @24
                                                    block  ;; label = @25
                                                      local.get 3
                                                      nop
                                                      f32.const 0x1.8f97e2p-113 (;=1.5031e-34;)
                                                      i32.reinterpret_f32
                                                      loop (result i64)  ;; label = @26
                                                        f64.const -0x1.e220b6c1725eep-787 (;=-2.31375e-237;)
                                                        f64.neg
                                                        f64.sqrt
                                                        i64.reinterpret_f64
                                                        f64.const -0x1.b80c005f66d1p+989 (;=-8.99342e+297;)
                                                        local.set 3
                                                        global.get 0
                                                        f64.sqrt
                                                        i32.trunc_f64_s
                                                        i32.load8_s offset=291036
                                                        br 25 (;@1;)
                                                        local.tee 2
                                                        i64.load offset=532461 align=2
                                                        local.tee 0
                                                        local.get 1
                                                        f32.nearest
                                                        f32.floor
                                                        i32.reinterpret_f32
                                                        i32.clz
                                                        i64.load8_u offset=971130
                                                        nop
                                                        i64.const 3312428060535363540
                                                        f64.const -0x1.73e9b5cc1b56cp+219 (;=-1.22397e+66;)
                                                        local.tee 3
                                                        f64.abs
                                                        memory.size
                                                        f64.const -0x1.a65432ab2d261p-488 (;=-2.0643e-147;)
                                                        local.tee 3
                                                        f64.floor
                                                        f64.store offset=786759493 align=4
                                                        i32.const -128712199
                                                        i32.load8_u offset=487137
                                                        f32.reinterpret_i32
                                                        f32.ceil
                                                        i32.const -1373385705
                                                        i64.load offset=323730 align=4
                                                        global.get 0
                                                        i64.trunc_f64_s
                                                        i64.le_u
                                                        f32.load offset=134622 align=2
                                                        f32.copysign
                                                        f64.promote_f32
                                                        f64.ne
                                                        i32.load16_s offset=81448596
                                                        f64.convert_i32_s
                                                        i32.const -1050325117
                                                        i64.load8_s offset=350446
                                                        call 2
                                                        block (result f64)  ;; label = @27
                                                          block  ;; label = @28
                                                            local.get 3
                                                            f64.trunc
                                                            i64.const 7997882204480262787
                                                            loop  ;; label = @29
                                                              block (result f32)  ;; label = @30
                                                                f64.const 0x1.277b07fda834fp-117 (;=6.94672e-36;)
                                                                memory.size
                                                                f32.convert_i32_s
                                                                local.set 1
                                                                f64.neg
                                                                f64.sqrt
                                                                i64.trunc_f64_s
                                                                f64.reinterpret_i64
                                                                i64.trunc_sat_f64_s
                                                                local.set 0
                                                                loop  ;; label = @31
                                                                end
                                                                i32.const -405986867
                                                                i32.load8_s offset=971653
                                                                i32.load8_s offset=861134
                                                                if (result f64)  ;; label = @31
                                                                  br 9 (;@22;)
                                                                  block  ;; label = @32
                                                                    br 4 (;@28;)
                                                                    f32.const -0x1.52229p-69 (;=-2.23759e-21;)
                                                                    i32.trunc_f32_u
                                                                    i64.load8_u offset=2558907089
                                                                    local.tee 0
                                                                    i64.extend32_s
                                                                    f64.convert_i64_s
                                                                    f32.demote_f64
                                                                    f32.floor
                                                                    f32.neg
                                                                    nop
                                                                    block  ;; label = @33
                                                                      i32.const 1052292535
                                                                      i32.clz
                                                                      i32.load16_s offset=542666 align=1
                                                                      loop (result f32)  ;; label = @34
                                                                        unreachable
                                                                        br 6 (;@28;)
                                                                        i32.const -2082158698
                                                                        i64.load offset=759430 align=4
                                                                        block (param i64) (result i64)  ;; label = @35
                                                                        end
                                                                        local.tee 0
                                                                        f64.convert_i64_s
                                                                        f64.nearest
                                                                        i32.trunc_sat_f64_s
                                                                        f32.load offset=538553872 align=1
                                                                        f32.ceil
                                                                        global.get 0
                                                                        f32.const -0x1.41f6f8p-13 (;=-0.000153525;)
                                                                        i32.trunc_sat_f32_u
                                                                        i64.load32_s offset=425807 align=1
                                                                        loop (result i32)  ;; label = @35
                                                                          block  ;; label = @36
                                                                            block (result i64)  ;; label = @37
                                                                              f64.const 0x1.ee5adf21d6516p-350 (;=8.41977e-106;)
                                                                              i64.const 6893106208212642123
                                                                              memory.size
                                                                              f32.const -0x1.3ff06cp-74 (;=-6.61619e-23;)
                                                                              i64.trunc_f32_u
                                                                              f64.convert_i64_s
                                                                              loop (result f64)  ;; label = @38
                                                                                i64.const 3208822317905991606
                                                                                f64.reinterpret_i64
                                                                                block (result f64)  ;; label = @39
                                                                                  memory.size
                                                                                  f32.convert_i32_u
                                                                                  local.get 1
                                                                                  i64.trunc_f32_u
                                                                                  i64.ctz
                                                                                  local.tee 0
                                                                                  local.get 3
                                                                                  f64.nearest
                                                                                  global.get 0
                                                                                  f64.nearest
                                                                                  br 30 (;@9;)
                                                                                  f64.eq
                                                                                  br_if 11 (;@28;)
                                                                                  memory.size
                                                                                  br_table 1 (;@38;) 3 (;@36;) 4 (;@35;) 5 (;@34;) 6 (;@33;) 7 (;@32;) 10 (;@29;) 11 (;@28;) 13 (;@26;) 14 (;@25;) 16 (;@23;) 17 (;@22;) 19 (;@20;) 21 (;@18;) 22 (;@17;) 23 (;@16;) 24 (;@15;) 25 (;@14;) 26 (;@13;) 27 (;@12;) 30 (;@9;) 31 (;@8;) 32 (;@7;) 33 (;@6;) 34 (;@5;) 35 (;@4;) 36 (;@3;) 38 (;@1;) 10 (;@29;)
                                                                                  f32.convert_i64_u
                                                                                  f32.mul
                                                                                  i32.trunc_sat_f32_u
                                                                                  local.set 2
                                                                                  f64.const 0x1.b545e2b36384ap+996 (;=1.1439e+300;)
                                                                                  local.tee 3
                                                                                  i32.trunc_sat_f64_u
                                                                                  local.get 3
                                                                                  local.get 0
                                                                                  call 3
                                                                                  i64.popcnt
                                                                                  f32.const 0x1.8a5016p+16 (;=100944;)
                                                                                  loop (result i32)  ;; label = @40
                                                                                    local.get 1
                                                                                    f32.const 0x1.906402p+61 (;=3.6064e+18;)
                                                                                    local.get 2
                                                                                    loop  ;; label = @41
                                                                                      local.get 3
                                                                                      loop  ;; label = @42
                                                                                        nop
                                                                                        f64.const 0x1.6be8b9685426cp+210 (;=2.33912e+63;)
                                                                                        f64.floor
                                                                                        f32.demote_f64
                                                                                        i64.trunc_sat_f32_s
                                                                                        i64.ctz
                                                                                        local.set 0
                                                                                        f32.const 0x1.81638p+101 (;=3.8167e+30;)
                                                                                        f32.sqrt
                                                                                        local.set 1
                                                                                        memory.size
                                                                                        if  ;; label = @43
                                                                                          i32.const -1843658872
                                                                                          br_if 42 (;@1;)
                                                                                          i64.const 3252739253012477865
                                                                                          memory.size
                                                                                          i32.load16_s offset=1239450938
                                                                                          if (param i64) (result i64)  ;; label = @44
                                                                                            i64.popcnt
                                                                                            local.get 1
                                                                                            global.get 0
                                                                                            i32.trunc_sat_f64_u
                                                                                            i64.load16_u offset=723809
                                                                                            f32.const 0x1.d50274p+4 (;=29.3131;)
                                                                                            i64.trunc_sat_f32_s
                                                                                            memory.size
                                                                                            i32.popcnt
                                                                                            i64.load8_u offset=650008
                                                                                            i64.xor
                                                                                            i64.lt_u
                                                                                            i32.popcnt
                                                                                            i32.load8_s offset=12262
                                                                                            i32.load8_u offset=2452714838
                                                                                            i32.load offset=763531
                                                                                            f64.convert_i32_u
                                                                                            i64.trunc_f64_s
                                                                                            f32.convert_i64_s
                                                                                            f32.trunc
                                                                                            f32.min
                                                                                            f64.const 0x1.825d0fa3fac9cp-412 (;=1.42691e-124;)
                                                                                            memory.size
                                                                                            i64.load8_u offset=438163
                                                                                            global.get 0
                                                                                            br 28 (;@16;)
                                                                                            local.set 3
                                                                                            i64.extend16_s
                                                                                            i64.extend32_s
                                                                                            f32.convert_i64_u
                                                                                            br 9 (;@35;)
                                                                                            i64.trunc_f32_s
                                                                                            i64.const -9156438458198353449
                                                                                            i64.div_s
                                                                                            block  ;; label = @45
                                                                                              local.get 3
                                                                                              local.get 0
                                                                                              local.get 0
                                                                                              i64.extend32_s
                                                                                              memory.size
                                                                                              i32.load16_u offset=907657 align=1
                                                                                              br 37 (;@8;)
                                                                                              i32.const 1768153575
                                                                                              i32.eqz
                                                                                              i32.ne
                                                                                              br_if 5 (;@40;)
                                                                                              call 3
                                                                                              i64.lt_u
                                                                                              local.get 1
                                                                                              br 37 (;@8;)
                                                                                              f32.nearest
                                                                                              br 25 (;@20;)
                                                                                              local.set 1
                                                                                              global.get 0
                                                                                              br 13 (;@32;)
                                                                                              memory.size
                                                                                              f32.load offset=108355 align=1
                                                                                              f32.abs
                                                                                              f32.nearest
                                                                                              f64.promote_f32
                                                                                              local.tee 3
                                                                                              f64.gt
                                                                                              f32.load offset=56803 align=1
                                                                                              local.get 1
                                                                                              f32.trunc
                                                                                              f32.abs
                                                                                              i32.reinterpret_f32
                                                                                              br_if 32 (;@13;)
                                                                                              i64.trunc_sat_f32_s
                                                                                              loop (param i64) (result i64)  ;; label = @46
                                                                                                i32.wrap_i64
                                                                                                i64.load16_s offset=189457
                                                                                                i64.ctz
                                                                                                i32.wrap_i64
                                                                                                br_if 3 (;@43;)
                                                                                                br 18 (;@28;)
                                                                                                block  ;; label = @47
                                                                                                end
                                                                                                i64.const 1082556449838309008
                                                                                              end
                                                                                              global.get 2
                                                                                              i64.xor
                                                                                              global.set 2
                                                                                              global.get 3
                                                                                              i32.xor
                                                                                              global.set 3
                                                                                              i64.reinterpret_f64
                                                                                              global.get 1
                                                                                              i64.xor
                                                                                              global.set 1
                                                                                            end
                                                                                            global.get 2
                                                                                            i64.xor
                                                                                            global.set 2
                                                                                            i64.reinterpret_f64
                                                                                            global.get 1
                                                                                            i64.xor
                                                                                            global.set 1
                                                                                            i32.reinterpret_f32
                                                                                            global.get 4
                                                                                            i32.xor
                                                                                            global.set 4
                                                                                          end
                                                                                          global.get 2
                                                                                          i64.xor
                                                                                          global.set 2
                                                                                        end
                                                                                      end
                                                                                      i64.reinterpret_f64
                                                                                      global.get 1
                                                                                      i64.xor
                                                                                      global.set 1
                                                                                    end
                                                                                    global.get 3
                                                                                    i32.xor
                                                                                    global.set 3
                                                                                    i32.reinterpret_f32
                                                                                    global.get 4
                                                                                    i32.xor
                                                                                    global.set 4
                                                                                    i32.reinterpret_f32
                                                                                    global.get 4
                                                                                    i32.xor
                                                                                    global.set 4
                                                                                    i32.const -170741068
                                                                                  end
                                                                                  global.get 3
                                                                                  i32.xor
                                                                                  global.set 3
                                                                                  i32.reinterpret_f32
                                                                                  global.get 4
                                                                                  i32.xor
                                                                                  global.set 4
                                                                                  global.get 2
                                                                                  i64.xor
                                                                                  global.set 2
                                                                                  i64.reinterpret_f64
                                                                                  global.get 1
                                                                                  i64.xor
                                                                                  global.set 1
                                                                                  global.get 3
                                                                                  i32.xor
                                                                                  global.set 3
                                                                                  f64.const 0x1.9b5e713cc530ap-948 (;=6.75392e-286;)
                                                                                end
                                                                                i64.reinterpret_f64
                                                                                global.get 1
                                                                                i64.xor
                                                                                global.set 1
                                                                              end
                                                                              i64.reinterpret_f64
                                                                              global.get 1
                                                                              i64.xor
                                                                              global.set 1
                                                                              i64.reinterpret_f64
                                                                              global.get 1
                                                                              i64.xor
                                                                              global.set 1
                                                                              global.get 3
                                                                              i32.xor
                                                                              global.set 3
                                                                              global.get 2
                                                                              i64.xor
                                                                              global.set 2
                                                                              i64.reinterpret_f64
                                                                              global.get 1
                                                                              i64.xor
                                                                              global.set 1
                                                                              i64.const 7499446179537431679
                                                                            end
                                                                            global.get 2
                                                                            i64.xor
                                                                            global.set 2
                                                                          end
                                                                          i32.const -1311471287
                                                                        end
                                                                        global.get 3
                                                                        i32.xor
                                                                        global.set 3
                                                                        global.get 2
                                                                        i64.xor
                                                                        global.set 2
                                                                        i64.reinterpret_f64
                                                                        global.get 1
                                                                        i64.xor
                                                                        global.set 1
                                                                      end
                                                                      i32.reinterpret_f32
                                                                      global.get 4
                                                                      i32.xor
                                                                      global.set 4
                                                                      global.get 3
                                                                      i32.xor
                                                                      global.set 3
                                                                    end
                                                                    i32.reinterpret_f32
                                                                    global.get 4
                                                                    i32.xor
                                                                    global.set 4
                                                                  end
                                                                  f64.const -0x1.ad23d25192126p+134 (;=-3.65072e+40;)
                                                                else
                                                                  f64.const 0x1.8c255404c134ap-46 (;=2.19905e-14;)
                                                                end
                                                                i64.reinterpret_f64
                                                                global.get 1
                                                                i64.xor
                                                                global.set 1
                                                                f32.const 0x1.7a2a14p+100 (;=1.87258e+30;)
                                                              end
                                                              i32.reinterpret_f32
                                                              global.get 4
                                                              i32.xor
                                                              global.set 4
                                                            end
                                                            global.get 2
                                                            i64.xor
                                                            global.set 2
                                                            i64.reinterpret_f64
                                                            global.get 1
                                                            i64.xor
                                                            global.set 1
                                                          end
                                                          f64.const 0x1.a23f7739048f9p-638 (;=1.43237e-192;)
                                                        end
                                                        i64.reinterpret_f64
                                                        global.get 1
                                                        i64.xor
                                                        global.set 1
                                                        global.get 2
                                                        i64.xor
                                                        global.set 2
                                                        i64.reinterpret_f64
                                                        global.get 1
                                                        i64.xor
                                                        global.set 1
                                                        global.get 2
                                                        i64.xor
                                                        global.set 2
                                                        global.get 2
                                                        i64.xor
                                                        global.set 2
                                                        global.get 2
                                                        i64.xor
                                                        global.set 2
                                                      end
                                                      global.get 2
                                                      i64.xor
                                                      global.set 2
                                                      global.get 3
                                                      i32.xor
                                                      global.set 3
                                                      i64.reinterpret_f64
                                                      global.get 1
                                                      i64.xor
                                                      global.set 1
                                                    end
                                                    i32.const 634834194
                                                  end
                                                  global.get 3
                                                  i32.xor
                                                  global.set 3
                                                  i32.reinterpret_f32
                                                  global.get 4
                                                  i32.xor
                                                  global.set 4
                                                  global.get 2
                                                  i64.xor
                                                  global.set 2
                                                  i32.reinterpret_f32
                                                  global.get 4
                                                  i32.xor
                                                  global.set 4
                                                end
                                                i64.reinterpret_f64
                                                global.get 1
                                                i64.xor
                                                global.set 1
                                              end
                                            end
                                            global.get 2
                                            i64.xor
                                            global.set 2
                                          end
                                        end
                                        i64.reinterpret_f64
                                        global.get 1
                                        i64.xor
                                        global.set 1
                                        global.get 2
                                        i64.xor
                                        global.set 2
                                        i64.reinterpret_f64
                                        global.get 1
                                        i64.xor
                                        global.set 1
                                        i32.reinterpret_f32
                                        global.get 4
                                        i32.xor
                                        global.set 4
                                        global.get 2
                                        i64.xor
                                        global.set 2
                                        i64.reinterpret_f64
                                        global.get 1
                                        i64.xor
                                        global.set 1
                                      end
                                      f32.const 0x1.e19d22p-109 (;=2.89861e-33;)
                                    end
                                    i32.reinterpret_f32
                                    global.get 4
                                    i32.xor
                                    global.set 4
                                  end
                                  global.get 2
                                  i64.xor
                                  global.set 2
                                end
                              end
                              global.get 3
                              i32.xor
                              global.set 3
                            end
                            f32.const -0x1.8fbe3ap-73 (;=-1.6533e-22;)
                          end
                          i32.reinterpret_f32
                          global.get 4
                          i32.xor
                          global.set 4
                          i32.reinterpret_f32
                          global.get 4
                          i32.xor
                          global.set 4
                          i32.reinterpret_f32
                          global.get 4
                          i32.xor
                          global.set 4
                          global.get 3
                          i32.xor
                          global.set 3
                          i64.const -2932509214435401428
                        end
                        global.get 2
                        i64.xor
                        global.set 2
                        global.get 2
                        i64.xor
                        global.set 2
                        f32.const -0x1.413f6cp-77 (;=-8.30406e-24;)
                      end
                      i32.reinterpret_f32
                      global.get 4
                      i32.xor
                      global.set 4
                      i32.reinterpret_f32
                      global.get 4
                      i32.xor
                      global.set 4
                      i32.reinterpret_f32
                      global.get 4
                      i32.xor
                      global.set 4
                      i32.reinterpret_f32
                      global.get 4
                      i32.xor
                      global.set 4
                    end
                    global.get 3
                    i32.xor
                    global.set 3
                    global.get 2
                    i64.xor
                    global.set 2
                    i32.reinterpret_f32
                    global.get 4
                    i32.xor
                    global.set 4
                  end
                  i64.reinterpret_f64
                  global.get 1
                  i64.xor
                  global.set 1
                  drop
                end
              end
              i64.reinterpret_f64
              global.get 1
              i64.xor
              global.set 1
              global.get 2
              i64.xor
              global.set 2
              i32.const -1557812594
            end
            global.get 3
            i32.xor
            global.set 3
            i64.reinterpret_f64
            global.get 1
            i64.xor
            global.set 1
          end
        end
        i32.reinterpret_f32
        global.get 4
        i32.xor
        global.set 4
        i32.const -1045266668
      end
      global.get 3
      i32.xor
      global.set 3
      global.get 3
      i32.xor
      global.set 3
    end
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4
    i64.reinterpret_f64
    global.get 1
    i64.xor
    global.set 1
    global.get 2
    i64.xor
    global.set 2
    i64.reinterpret_f64
    global.get 1
    i64.xor
    global.set 1
    global.get 2
    i64.xor
    global.set 2
    global.get 2
    i64.xor
    global.set 2
    global.get 3
    i32.xor
    global.set 3
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4
    global.get 2
    i64.xor
    global.set 2
    global.get 2
    i64.xor
    global.set 2
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4)
  (func (;3;) (type 0) (param i64) (result i64)
    i64.const -4866869582315318076
    i32.const -710125233
    global.get 0
    f64.sqrt
    i64.trunc_f64_s
    i64.extend32_s
    i64.store offset=907188
    f32.const -0x1.5f8576p-64 (;=-7.44375e-20;)
    f32.floor
    local.get 0
    block (result i32)  ;; label = @1
      f32.const -0x1.b74366p+54 (;=-3.09104e+16;)
      i64.const -7814054380247937711
      local.tee 0
      f32.convert_i64_u
      f32.sub
      memory.size
      i32.load8_u offset=396714
      i64.load offset=827449 align=2
      block (result i64)  ;; label = @2
        local.get 0
        i32.const -2043523158
        br 1 (;@1;)
        i64.extend8_s
        i64.eqz
        i32.load8_u offset=2089450832
        i64.load offset=1048042 align=2
        loop  ;; label = @3
          f32.const -0x1.d4a76ap+27 (;=-2.4571e+08;)
          f32.neg
          local.get 0
          local.get 0
          loop (param i64) (result i64)  ;; label = @4
            local.get 0
            i64.const 4803637058780295054
            i64.lt_s
            i32.extend16_s
            br 1 (;@3;)
            i32.load8_u offset=934933
            f32.const -0x1.9e2dep-76 (;=-2.14126e-23;)
            i32.reinterpret_f32
            f64.convert_i32_s
            f64.store offset=286752
            f64.convert_i64_s
            i64.trunc_f64_s
            i64.extend16_s
            i64.popcnt
            f64.const -0x1.f22b7a2e72313p-430 (;=-7.01842e-130;)
            br 1 (;@3;)
            i64.reinterpret_f64
            global.get 1
            i64.xor
            global.set 1
          end
          global.get 2
          i64.xor
          global.set 2
          global.get 2
          i64.xor
          global.set 2
          i32.reinterpret_f32
          global.get 4
          i32.xor
          global.set 4
        end
      end
      global.get 2
      i64.xor
      global.set 2
      global.get 2
      i64.xor
      global.set 2
      i32.reinterpret_f32
      global.get 4
      i32.xor
      global.set 4
      i32.const 230005436
    end
    global.get 3
    i32.xor
    global.set 3
    global.get 2
    i64.xor
    global.set 2
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4)
  (func (;4;) (result i64)
    (local i64 i32)
    i64.const 1
    local.set 0
    memory.size
    i64.load16_s offset=2980496870
    global.get 0
    f32.const -0x1.2d5f5p+76 (;=-8.89494e+22;)
    f32.trunc
    block (result f32)  ;; label = @1
      i32.const 1093046162
      i32.load8_u offset=952637
      i32.load offset=148908
      i64.const -578433564759625923
      f64.convert_i64_s
      f64.abs
      i64.reinterpret_f64
      f32.convert_i64_u
      f32.store offset=1033560 align=2
      global.get 0
      i64.const 5463879877535515325
      br 1 (;@0;)
      i64.const 3326998138095116671
      block  ;; label = @2
        global.get 0
        f32.demote_f64
        i32.const -1421783561
        i32.extend8_s
        br_if 1 (;@1;)
        f64.const -0x1.450d426683333p-903 (;=-1.8777e-272;)
        br 0 (;@2;)
        i32.trunc_sat_f64_s
        i64.load16_s offset=655397 align=1
        f64.const 0x1.5b4c8596472b9p+680 (;=6.80551e+204;)
        loop  ;; label = @3
          global.get 0
          i64.trunc_f64_s
          i64.extend32_s
          i64.const -6656590258734748370
          local.get 0
          f32.const 0x1.635946p+52 (;=6.25136e+15;)
          i32.trunc_sat_f32_u
          if (param i64) (result i64)  ;; label = @4
            f64.convert_i64_u
            f64.neg
            f64.abs
            block (result f32)  ;; label = @5
              f64.const -0x1.30d4e9ed2d4bcp+350 (;=-2.73098e+105;)
              loop (result i32)  ;; label = @6
                block  ;; label = @7
                  f64.const -0x1.853e60beed7fp-541 (;=-2.11229e-163;)
                  memory.size
                  loop (result f64)  ;; label = @8
                    nop
                    local.get 0
                    f64.reinterpret_i64
                    f64.nearest
                    f32.demote_f64
                    i32.trunc_f32_s
                    i64.load32_s offset=863806 align=2
                    f64.const 0x1.9de3708537e79p-1008 (;=5.89397e-304;)
                    i64.reinterpret_f64
                    global.get 2
                    i64.xor
                    global.set 2
                    drop
                    f64.const 0x1.e612a9eba77f8p-949 (;=3.99021e-286;)
                  end
                  i64.reinterpret_f64
                  global.get 1
                  i64.xor
                  global.set 1
                  global.get 3
                  i32.xor
                  global.set 3
                  i64.reinterpret_f64
                  global.get 1
                  i64.xor
                  global.set 1
                end
                i32.const 451718088
              end
              global.get 3
              i32.xor
              global.set 3
              i64.reinterpret_f64
              global.get 1
              i64.xor
              global.set 1
              f32.const 0x1.46fa1cp-25 (;=3.80651e-08;)
            end
            i32.reinterpret_f32
            global.get 4
            i32.xor
            global.set 4
            i64.reinterpret_f64
            global.get 1
            i64.xor
            global.set 1
            i64.const -2021588397260367565
          end
          global.get 2
          i64.xor
          global.set 2
          global.get 2
          i64.xor
          global.set 2
          global.get 2
          i64.xor
          global.set 2
        end
        i64.reinterpret_f64
        global.get 1
        i64.xor
        global.set 1
        global.get 2
        i64.xor
        global.set 2
        i32.reinterpret_f32
        global.get 4
        i32.xor
        global.set 4
      end
      global.get 2
      i64.xor
      global.set 2
      i64.reinterpret_f64
      global.get 1
      i64.xor
      global.set 1
      f32.const 0x1.86df3cp+29 (;=8.19718e+08;)
    end
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4
    i64.reinterpret_f64
    global.get 1
    i64.xor
    global.set 1)
  (func (;5;) (type 0) (param i64) (result i64)
    loop (result f32)  ;; label = @1
      loop  ;; label = @2
        f64.const -0x1.6e190cc40e673p+169 (;=-1.07011e+51;)
        f64.trunc
        memory.size
        f64.load offset=154072
        f64.le
        i64.extend_i32_u
        f64.reinterpret_i64
        f64.trunc
        i64.reinterpret_f64
        global.get 0
        loop  ;; label = @3
          br 1 (;@2;)
          global.get 0
          local.get 0
          i64.extend16_s
          i64.const 2508304895111279644
          f32.const 0x1.074188p+105 (;=4.17146e+31;)
          i64.trunc_f32_s
          f64.const 0x1.6aea3d4b3b83p-894 (;=1.07337e-269;)
          i64.const -5817479850742211232
          f32.convert_i64_s
          global.get 0
          i32.trunc_f64_u
          loop (result i64)  ;; label = @4
            i64.const 8425531944433943403
            block (result f64)  ;; label = @5
              loop  ;; label = @6
                loop (result i32)  ;; label = @7
                  local.get 0
                  i64.popcnt
                  local.get 0
                  i64.rotr
                  local.set 0
                  global.get 0
                  i64.trunc_sat_f64_u
                  block  ;; label = @8
                    block (result f32)  ;; label = @9
                      f32.const 0x1.dd45cep-114 (;=8.9765e-35;)
                      f32.trunc
                      i64.trunc_sat_f32_u
                      f64.const 0x1.87ae9c1fcf094p-44 (;=8.69709e-14;)
                      i64.reinterpret_f64
                      f64.convert_i64_u
                      f64.trunc
                      i64.trunc_f64_u
                      i64.lt_s
                      br_table 1 (;@8;) 2 (;@7;) 3 (;@6;) 5 (;@4;) 6 (;@3;) 7 (;@2;) 8 (;@1;) 2 (;@7;)
                      loop  ;; label = @10
                        f32.const 0x1.f1eab8p-11 (;=0.000949701;)
                        i32.trunc_sat_f32_u
                        f32.load offset=55729 align=1
                        i64.const -1456241357392520831
                        i64.popcnt
                        loop  ;; label = @11
                        end
                        f64.convert_i64_s
                        f64.neg
                        i64.trunc_sat_f64_s
                        f64.const -0x1.c59ffb51a56efp-940 (;=-1.90661e-283;)
                        f64.trunc
                        i64.trunc_sat_f64_u
                        i64.shr_s
                        global.get 0
                        memory.size
                        memory.size
                        i32.eq
                        local.get 0
                        i64.extend8_s
                        f64.convert_i64_u
                        block  ;; label = @11
                          global.get 0
                          i64.trunc_sat_f64_s
                          i64.eqz
                          i32.load offset=244862
                          global.get 0
                          i64.const -4211917144309738350
                          local.set 0
                          global.set 0
                          global.get 0
                          br 7 (;@4;)
                          f32.const -0x1.ad03dap+49 (;=-9.43414e+14;)
                          nop
                          f32.const -0x1.036a28p-70 (;=-8.58331e-22;)
                          i32.const 169349329
                          f32.const -0x1.b6990ap-92 (;=-3.45993e-28;)
                          i32.const 1309849426
                          br_if 3 (;@8;)
                          memory.size
                          br_table 0 (;@11;) 1 (;@10;) 3 (;@8;) 4 (;@7;) 5 (;@6;) 7 (;@4;) 8 (;@3;) 9 (;@2;) 10 (;@1;) 3 (;@8;)
                          i32.trunc_f32_s
                          i32.ge_u
                          i32.clz
                          i64.load8_u offset=260379817
                          f64.convert_i64_u
                          global.get 0
                          f64.sqrt
                          f64.le
                          f64.load offset=359302 align=2
                          i32.trunc_sat_f64_u
                          i32.popcnt
                          br_if 7 (;@4;)
                          i64.trunc_sat_f32_s
                          global.get 0
                          local.get 0
                          f64.convert_i64_u
                          i32.const 401198275
                          select
                          i64.trunc_sat_f64_s
                          i64.rotr
                          memory.size
                          i32.extend16_s
                          i32.load8_s offset=787892
                          i32.load offset=309987
                          i64.load offset=212900 align=4
                          memory.size
                          i32.load16_u offset=252393 align=1
                          i64.const 8616080565191526773
                          local.set 0
                          memory.grow
                          f32.const 0x1.0117a8p-76 (;=1.32914e-23;)
                          i32.trunc_f32_u
                          i64.load8_u offset=3656065972
                          block (param i64) (result i64)  ;; label = @12
                          end
                          br 4 (;@7;)
                          f64.convert_i64_s
                          local.get 0
                          i64.const -4146894685481983592
                          block (result f32)  ;; label = @12
                            f64.const 0x1.71b5507e5f96dp-333 (;=8.25336e-101;)
                            i32.trunc_sat_f64_u
                            f64.convert_i32_u
                            i32.trunc_f64_s
                            i64.load32_s offset=1016129 align=1
                            f32.convert_i64_u
                            global.get 0
                            global.set 0
                            local.get 0
                            call 9
                            global.get 0
                            block  ;; label = @13
                              i64.const -3821513083715781430
                              local.get 0
                              i64.eqz
                              br 2 (;@11;)
                              f64.load offset=2821504818 align=2
                              global.set 0
                              i64.extend32_s
                              call 5
                              f64.convert_i64_s
                              loop (result i32)  ;; label = @14
                                local.get 0
                                i32.wrap_i64
                                i32.extend16_s
                                i64.load8_s offset=418542
                                global.get 0
                                f64.abs
                                br 9 (;@5;)
                                block  ;; label = @15
                                  i64.const 1898472015023142656
                                  f64.convert_i64_u
                                  i32.trunc_f64_s
                                  br 12 (;@3;)
                                  i32.load8_u offset=471112183
                                  f64.convert_i32_s
                                  i64.const -6031419028174260313
                                  i64.ctz
                                  i32.const 2046982064
                                  br_table 0 (;@15;) 1 (;@14;) 2 (;@13;) 4 (;@11;) 5 (;@10;) 7 (;@8;) 8 (;@7;) 9 (;@6;) 11 (;@4;) 12 (;@3;) 13 (;@2;) 14 (;@1;) 11 (;@4;)
                                  br 4 (;@11;)
                                  i32.wrap_i64
                                  i32.extend16_s
                                  memory.size
                                  i32.extend8_s
                                  i32.add
                                  i32.const -2063204549
                                  f64.convert_i32_s
                                  i64.trunc_sat_f64_u
                                  block (result f32)  ;; label = @16
                                    local.get 0
                                    i64.eqz
                                    i64.load16_s offset=239292581
                                    f32.convert_i64_u
                                    f32.ceil
                                    i64.trunc_f32_s
                                    i64.const -2185398747046792345
                                    f32.const 0x1.35830ep+24 (;=2.02842e+07;)
                                    f32.sqrt
                                    f32.neg
                                    br 0 (;@16;)
                                    i32.wrap_i64
                                    f64.const 0x1.ceac211d0cfd4p+813 (;=9.87234e+244;)
                                    global.get 0
                                    f64.eq
                                    i64.load16_s offset=67405 align=1
                                    i64.clz
                                    local.get 0
                                    br 12 (;@4;)
                                    i64.rem_s
                                    i64.store offset=718667 align=4
                                    f64.convert_i64_s
                                    loop  ;; label = @17
                                      br 14 (;@3;)
                                      i64.const 6780679836114871227
                                      f32.const 0x1.87e16p+16 (;=100321;)
                                      i64.trunc_sat_f32_u
                                      loop  ;; label = @18
                                        global.get 0
                                        f64.neg
                                        local.get 0
                                        global.get 0
                                        f64.sqrt
                                        f64.ceil
                                        i32.trunc_f64_s
                                        i64.load offset=3371975939 align=1
                                        i64.or
                                        br 18 (;@0;)
                                        i64.trunc_sat_f64_s
                                        call 8
                                        f64.const 0x1.835e07a18c8f2p+358 (;=8.88426e+107;)
                                        i64.trunc_sat_f64_s
                                        i64.rem_u
                                        block (param i64) (result i64)  ;; label = @19
                                          global.get 0
                                          f32.const 0x1.889cb4p-87 (;=9.91092e-27;)
                                          global.get 0
                                          f64.const 0x1.e148e4569dad8p+793 (;=9.79374e+238;)
                                          f64.eq
                                          loop  ;; label = @20
                                            i32.const -429090688
                                            i64.load32_u offset=792601 align=2
                                            i64.extend8_s
                                            i64.extend8_s
                                            i64.const 4445416608259858609
                                            i64.rotl
                                            global.get 0
                                            i64.trunc_f64_s
                                            i64.gt_s
                                            br 13 (;@7;)
                                            i64.load offset=362293
                                            local.tee 0
                                            i64.popcnt
                                            loop  ;; label = @21
                                            end
                                            block  ;; label = @21
                                              br 20 (;@1;)
                                              loop (result i32)  ;; label = @22
                                                loop  ;; label = @23
                                                  block  ;; label = @24
                                                    block  ;; label = @25
                                                      loop  ;; label = @26
                                                        global.get 0
                                                        global.get 0
                                                        f64.trunc
                                                        f64.nearest
                                                        i32.const 2003332602
                                                        i32.ctz
                                                        i32.load16_s offset=2931451675
                                                        i32.ctz
                                                        i64.load16_u offset=710591
                                                        i64.ctz
                                                        i64.extend16_s
                                                        br 0 (;@26;)
                                                        f32.convert_i64_s
                                                        loop  ;; label = @27
                                                          memory.size
                                                          i32.eqz
                                                          i32.load16_u offset=879685 align=1
                                                          i32.load16_u offset=620317
                                                          i64.load16_s offset=1003546 align=1
                                                          f64.const 0x1.3acfb42e6851ap+482 (;=1.53557e+145;)
                                                          f64.abs
                                                          f32.const -0x1.237b0cp-46 (;=-1.61804e-14;)
                                                          f32.sqrt
                                                          i32.trunc_sat_f32_u
                                                          i64.load8_u offset=567617
                                                          f32.const 0x1.a88c88p-68 (;=5.61886e-21;)
                                                          i64.trunc_f32_u
                                                          i64.eq
                                                          i64.load8_s offset=466738
                                                          block (param i64) (result i64)  ;; label = @28
                                                            i64.eqz
                                                            if  ;; label = @29
                                                              i64.const 1403823571163735096
                                                              f64.reinterpret_i64
                                                              local.get 0
                                                              loop  ;; label = @30
                                                                i32.const 689360335
                                                                memory.grow
                                                                loop  ;; label = @31
                                                                end
                                                                i32.load offset=612592
                                                                br 22 (;@8;)
                                                                f64.load offset=907135 align=1
                                                                i64.trunc_f64_u
                                                                f32.const -0x1.68f1fep-77 (;=-9.33022e-24;)
                                                                f32.abs
                                                                i32.trunc_f32_s
                                                                i64.load32_u offset=702057 align=2
                                                                i64.gt_u
                                                                i32.load16_u offset=37998
                                                                i64.extend_i32_s
                                                                block (result i64)  ;; label = @31
                                                                  local.get 0
                                                                  f64.reinterpret_i64
                                                                  memory.size
                                                                  i64.const -8593707921745541685
                                                                  block (param i64) (result i64)  ;; label = @32
                                                                    i32.const -1689961906
                                                                    i32.ctz
                                                                    f32.load offset=432258
                                                                    f32.floor
                                                                    br 3 (;@29;)
                                                                    i64.trunc_sat_f32_u
                                                                    i64.rotr
                                                                    br 4 (;@28;)
                                                                    loop  ;; label = @33
                                                                      local.get 0
                                                                      local.set 0
                                                                      loop  ;; label = @34
                                                                        block  ;; label = @35
                                                                          br 12 (;@23;)
                                                                          br 21 (;@14;)
                                                                          local.get 0
                                                                          global.get 0
                                                                          i32.const 180185073
                                                                          i32.load16_u offset=417132
                                                                          i64.load8_s offset=3730176972
                                                                          i64.extend8_s
                                                                          block (result i64)  ;; label = @36
                                                                            i32.const -1557232133
                                                                            f32.convert_i32_u
                                                                            f32.const 0x1.a26738p-52 (;=3.62907e-16;)
                                                                            f32.ne
                                                                            br_table 1 (;@35;) 2 (;@34;) 3 (;@33;) 6 (;@30;) 7 (;@29;) 9 (;@27;) 10 (;@26;) 11 (;@25;) 12 (;@24;) 13 (;@23;) 14 (;@22;) 15 (;@21;) 16 (;@20;) 18 (;@18;) 19 (;@17;) 21 (;@15;) 22 (;@14;) 23 (;@13;) 25 (;@11;) 26 (;@10;) 28 (;@8;) 29 (;@7;) 30 (;@6;) 32 (;@4;) 33 (;@3;) 34 (;@2;) 35 (;@1;) 30 (;@6;)
                                                                            block  ;; label = @37
                                                                              i64.const 380641792561501627
                                                                              i64.popcnt
                                                                              global.get 0
                                                                              f64.nearest
                                                                              global.set 0
                                                                              f64.reinterpret_i64
                                                                              f32.const -0x1.f3559cp-96 (;=-2.46191e-29;)
                                                                              f32.trunc
                                                                              f64.const 0x1.09d48507adf81p+432 (;=1.15166e+130;)
                                                                              f64.ceil
                                                                              i32.const -1876208891
                                                                              f64.load offset=3806643624
                                                                              f64.trunc
                                                                              f64.abs
                                                                              f64.lt
                                                                              br_if 21 (;@16;)
                                                                              f32.neg
                                                                              i32.reinterpret_f32
                                                                              f32.reinterpret_i32
                                                                              i32.reinterpret_f32
                                                                              br 4 (;@33;)
                                                                              f64.load offset=100537
                                                                              global.set 0
                                                                              f32.demote_f64
                                                                              i64.const 5790057448016214917
                                                                              local.tee 0
                                                                              loop  ;; label = @38
                                                                                memory.size
                                                                                i64.extend_i32_s
                                                                                f32.const 0x1.13ed7ap+67 (;=1.59061e+20;)
                                                                                loop (result f32)  ;; label = @39
                                                                                  block (result f64)  ;; label = @40
                                                                                    i32.const 1897760892
                                                                                    br_if 32 (;@8;)
                                                                                    block (result f32)  ;; label = @41
                                                                                      f64.const -0x1.d110fcc2dff22p-167 (;=-9.71104e-51;)
                                                                                      i32.trunc_f64_s
                                                                                      i32.load8_s offset=272077
                                                                                      i64.load8_u offset=462675
                                                                                      f64.const -0x1.88320ee62f13dp+505 (;=-1.60476e+152;)
                                                                                      br 39 (;@2;)
                                                                                      i64.trunc_sat_f64_u
                                                                                      i64.extend32_s
                                                                                      i64.sub
                                                                                      i64.extend8_s
                                                                                      block (result i64)  ;; label = @42
                                                                                        i32.const 237117898
                                                                                        memory.size
                                                                                        f32.const 0x1.c6fae4p+115 (;=7.38247e+34;)
                                                                                        f32.abs
                                                                                        i64.const 8247309759526764467
                                                                                        i32.const -1257949962
                                                                                        br_table 3 (;@39;) 4 (;@38;) 5 (;@37;) 7 (;@35;) 8 (;@34;) 9 (;@33;) 12 (;@30;) 13 (;@29;) 15 (;@27;) 16 (;@26;) 17 (;@25;) 18 (;@24;) 19 (;@23;) 20 (;@22;) 21 (;@21;) 22 (;@20;) 24 (;@18;) 25 (;@17;) 27 (;@15;) 28 (;@14;) 29 (;@13;) 31 (;@11;) 32 (;@10;) 34 (;@8;) 35 (;@7;) 36 (;@6;) 38 (;@4;) 39 (;@3;) 40 (;@2;) 41 (;@1;) 34 (;@8;)
                                                                                        i64.extend32_s
                                                                                        f32.const -0x1.d0ccd8p+89 (;=-1.12382e+27;)
                                                                                        f32.sqrt
                                                                                        f32.abs
                                                                                        f64.promote_f32
                                                                                        f32.demote_f64
                                                                                        memory.size
                                                                                        i64.load32_u offset=664522 align=1
                                                                                        i64.clz
                                                                                        global.get 0
                                                                                        nop
                                                                                        global.get 0
                                                                                        f64.sqrt
                                                                                        i64.trunc_sat_f64_s
                                                                                        i64.ctz
                                                                                        f64.convert_i64_s
                                                                                        i64.trunc_sat_f64_u
                                                                                        br 11 (;@31;)
                                                                                        f64.sqrt
                                                                                        loop  ;; label = @43
                                                                                          loop (result f64)  ;; label = @44
                                                                                            global.get 0
                                                                                            f64.const -0x1.2da87e996d7b4p+959 (;=-5.74171e+288;)
                                                                                            i64.trunc_f64_s
                                                                                            f64.convert_i64_s
                                                                                            f64.abs
                                                                                            i32.const 1676315820
                                                                                            global.get 0
                                                                                            local.get 0
                                                                                            i64.extend16_s
                                                                                            br 16 (;@28;)
                                                                                            f64.sqrt
                                                                                            block  ;; label = @45
                                                                                              i64.const 7386985833348073612
                                                                                              f64.convert_i64_s
                                                                                              i32.trunc_sat_f64_u
                                                                                              global.get 0
                                                                                              f32.const -0x1.e77f66p-8 (;=-0.00743862;)
                                                                                              local.get 0
                                                                                              i64.popcnt
                                                                                              i64.popcnt
                                                                                              memory.size
                                                                                              i32.load offset=960980
                                                                                              i64.load32_u offset=355933 align=2
                                                                                              local.get 0
                                                                                              i64.eqz
                                                                                              local.get 0
                                                                                              i64.extend16_s
                                                                                              i32.const -275971860
                                                                                              i64.load8_s offset=856960
                                                                                              i64.le_s
                                                                                              i64.extend_i32_s
                                                                                              local.get 0
                                                                                              local.tee 0
                                                                                              i64.rem_u
                                                                                              i64.eqz
                                                                                              i32.load8_s offset=187273
                                                                                              i32.add
                                                                                              f64.const -0x1.ade02c5dcc78dp+403 (;=-3.4689e+121;)
                                                                                              f32.const 0x1.92d856p+85 (;=6.08762e+25;)
                                                                                              i32.trunc_sat_f32_s
                                                                                              i64.load32_u offset=1033476
                                                                                              i64.clz
                                                                                              f64.convert_i64_s
                                                                                              loop (result i32)  ;; label = @46
                                                                                                memory.size
                                                                                                local.get 0
                                                                                                i64.extend16_s
                                                                                                local.get 0
                                                                                                i64.eqz
                                                                                                i32.load16_s offset=102401 align=1
                                                                                                i32.load8_u offset=3772339713
                                                                                                i32.popcnt
                                                                                                f64.convert_i32_s
                                                                                                i64.trunc_sat_f64_s
                                                                                                loop (result f32)  ;; label = @47
                                                                                                  i64.const -1956454086699708034
                                                                                                  i64.popcnt
                                                                                                  nop
                                                                                                  block (result f64)  ;; label = @48
                                                                                                    f32.const -0x1.b23fccp-64 (;=-9.19558e-20;)
                                                                                                    block  ;; label = @49
                                                                                                      loop (result f64)  ;; label = @50
                                                                                                        local.get 0
                                                                                                        f32.convert_i64_u
                                                                                                        f32.neg
                                                                                                        i32.trunc_sat_f32_s
                                                                                                        f32.load offset=1257214682
                                                                                                        block  ;; label = @51
                                                                                                          loop (result f64)  ;; label = @52
                                                                                                            f32.const -0x1.328046p+21 (;=-2.51086e+06;)
                                                                                                            block  ;; label = @53
                                                                                                              local.get 0
                                                                                                              br 46 (;@7;)
                                                                                                              local.set 0
                                                                                                              i64.const 207479910404896965
                                                                                                              i64.extend8_s
                                                                                                              global.get 0
                                                                                                              f64.neg
                                                                                                              f64.neg
                                                                                                              f64.nearest
                                                                                                              i64.const -2349033674792790033
                                                                                                              i64.const -1213758183706179058
                                                                                                              nop
                                                                                                              f64.convert_i64_s
                                                                                                              i32.trunc_sat_f64_u
                                                                                                              i64.load32_u offset=205208 align=1
                                                                                                              i64.or
                                                                                                              i64.clz
                                                                                                              global.get 2
                                                                                                              i64.xor
                                                                                                              global.set 2
                                                                                                              i64.reinterpret_f64
                                                                                                              global.get 1
                                                                                                              i64.xor
                                                                                                              global.set 1
                                                                                                              global.get 2
                                                                                                              i64.xor
                                                                                                              global.set 2
                                                                                                            end
                                                                                                            i32.reinterpret_f32
                                                                                                            global.get 4
                                                                                                            i32.xor
                                                                                                            global.set 4
                                                                                                            f64.const 0x1.465a10f17846ep+482 (;=1.59186e+145;)
                                                                                                          end
                                                                                                          i64.reinterpret_f64
                                                                                                          global.get 1
                                                                                                          i64.xor
                                                                                                          global.set 1
                                                                                                        end
                                                                                                        i32.reinterpret_f32
                                                                                                        global.get 4
                                                                                                        i32.xor
                                                                                                        global.set 4
                                                                                                        f64.const 0x1.ad557bd205331p+844 (;=1.9673e+254;)
                                                                                                      end
                                                                                                      i64.reinterpret_f64
                                                                                                      global.get 1
                                                                                                      i64.xor
                                                                                                      global.set 1
                                                                                                    end
                                                                                                    i32.reinterpret_f32
                                                                                                    global.get 4
                                                                                                    i32.xor
                                                                                                    global.set 4
                                                                                                    f64.const -0x1.620a28a57c4f4p+835 (;=-3.16853e+251;)
                                                                                                  end
                                                                                                  i64.reinterpret_f64
                                                                                                  global.get 1
                                                                                                  i64.xor
                                                                                                  global.set 1
                                                                                                  global.get 2
                                                                                                  i64.xor
                                                                                                  global.set 2
                                                                                                  f32.const -0x1.b6fd76p-61 (;=-7.43678e-19;)
                                                                                                end
                                                                                                i32.reinterpret_f32
                                                                                                global.get 4
                                                                                                i32.xor
                                                                                                global.set 4
                                                                                                global.get 2
                                                                                                i64.xor
                                                                                                global.set 2
                                                                                                global.get 2
                                                                                                i64.xor
                                                                                                global.set 2
                                                                                              end
                                                                                              global.get 3
                                                                                              i32.xor
                                                                                              global.set 3
                                                                                              i64.reinterpret_f64
                                                                                              global.get 1
                                                                                              i64.xor
                                                                                              global.set 1
                                                                                              i64.reinterpret_f64
                                                                                              global.get 1
                                                                                              i64.xor
                                                                                              global.set 1
                                                                                              global.get 3
                                                                                              i32.xor
                                                                                              global.set 3
                                                                                              global.get 2
                                                                                              i64.xor
                                                                                              global.set 2
                                                                                              global.get 2
                                                                                              i64.xor
                                                                                              global.set 2
                                                                                              i32.reinterpret_f32
                                                                                              global.get 4
                                                                                              i32.xor
                                                                                              global.set 4
                                                                                              i64.reinterpret_f64
                                                                                              global.get 1
                                                                                              i64.xor
                                                                                              global.set 1
                                                                                              global.get 3
                                                                                              i32.xor
                                                                                              global.set 3
                                                                                            end
                                                                                            i64.reinterpret_f64
                                                                                            global.get 1
                                                                                            i64.xor
                                                                                            global.set 1
                                                                                            global.get 3
                                                                                            i32.xor
                                                                                            global.set 3
                                                                                            i64.reinterpret_f64
                                                                                            global.get 1
                                                                                            i64.xor
                                                                                            global.set 1
                                                                                          end
                                                                                          i64.reinterpret_f64
                                                                                          global.get 1
                                                                                          i64.xor
                                                                                          global.set 1
                                                                                        end
                                                                                        i64.reinterpret_f64
                                                                                        global.get 1
                                                                                        i64.xor
                                                                                        global.set 1
                                                                                        global.get 2
                                                                                        i64.xor
                                                                                        global.set 2
                                                                                        i32.reinterpret_f32
                                                                                        global.get 4
                                                                                        i32.xor
                                                                                        global.set 4
                                                                                        global.get 2
                                                                                        i64.xor
                                                                                        global.set 2
                                                                                        i32.reinterpret_f32
                                                                                        global.get 4
                                                                                        i32.xor
                                                                                        global.set 4
                                                                                        global.get 3
                                                                                        i32.xor
                                                                                        global.set 3
                                                                                        global.get 3
                                                                                        i32.xor
                                                                                        global.set 3
                                                                                        i64.const -4059371412885484692
                                                                                      end
                                                                                      global.get 2
                                                                                      i64.xor
                                                                                      global.set 2
                                                                                      global.get 2
                                                                                      i64.xor
                                                                                      global.set 2
                                                                                      f32.const 0x1.67d7a4p-122 (;=2.6437e-37;)
                                                                                    end
                                                                                    i32.reinterpret_f32
                                                                                    global.get 4
                                                                                    i32.xor
                                                                                    global.set 4
                                                                                    f64.const 0x1.1b29a7a54dd88p+352 (;=1.01474e+106;)
                                                                                  end
                                                                                  i64.reinterpret_f64
                                                                                  global.get 1
                                                                                  i64.xor
                                                                                  global.set 1
                                                                                  f32.const -0x1.e8b456p+125 (;=-8.12e+37;)
                                                                                end
                                                                                i32.reinterpret_f32
                                                                                global.get 4
                                                                                i32.xor
                                                                                global.set 4
                                                                                i32.reinterpret_f32
                                                                                global.get 4
                                                                                i32.xor
                                                                                global.set 4
                                                                                global.get 2
                                                                                i64.xor
                                                                                global.set 2
                                                                              end
                                                                              global.get 2
                                                                              i64.xor
                                                                              global.set 2
                                                                              i32.reinterpret_f32
                                                                              global.get 4
                                                                              i32.xor
                                                                              global.set 4
                                                                            end
                                                                            i64.const 18049863574171317
                                                                          end
                                                                          global.get 2
                                                                          i64.xor
                                                                          global.set 2
                                                                          global.get 2
                                                                          i64.xor
                                                                          global.set 2
                                                                          i64.reinterpret_f64
                                                                          global.get 1
                                                                          i64.xor
                                                                          global.set 1
                                                                          global.get 2
                                                                          i64.xor
                                                                          global.set 2
                                                                        end
                                                                      end
                                                                    end
                                                                    i64.const -228523705820001040
                                                                  end
                                                                  global.get 2
                                                                  i64.xor
                                                                  global.set 2
                                                                  global.get 3
                                                                  i32.xor
                                                                  global.set 3
                                                                  i64.reinterpret_f64
                                                                  global.get 1
                                                                  i64.xor
                                                                  global.set 1
                                                                  i64.const -9068306580905247643
                                                                end
                                                                global.get 2
                                                                i64.xor
                                                                global.set 2
                                                                global.get 2
                                                                i64.xor
                                                                global.set 2
                                                              end
                                                              global.get 2
                                                              i64.xor
                                                              global.set 2
                                                              i64.reinterpret_f64
                                                              global.get 1
                                                              i64.xor
                                                              global.set 1
                                                            end
                                                            i64.const 4196409268736667131
                                                          end
                                                          global.get 2
                                                          i64.xor
                                                          global.set 2
                                                          drop
                                                          global.get 2
                                                          i64.xor
                                                          global.set 2
                                                        end
                                                        i32.reinterpret_f32
                                                        global.get 4
                                                        i32.xor
                                                        global.set 4
                                                        i64.reinterpret_f64
                                                        global.get 1
                                                        i64.xor
                                                        global.set 1
                                                        i64.reinterpret_f64
                                                        global.get 1
                                                        i64.xor
                                                        global.set 1
                                                      end
                                                    end
                                                  end
                                                end
                                                i32.const 976849578
                                              end
                                              global.get 3
                                              i32.xor
                                              global.set 3
                                            end
                                            global.get 2
                                            i64.xor
                                            global.set 2
                                          end
                                          global.get 3
                                          i32.xor
                                          global.set 3
                                          i32.reinterpret_f32
                                          global.get 4
                                          i32.xor
                                          global.set 4
                                          i64.reinterpret_f64
                                          global.get 1
                                          i64.xor
                                          global.set 1
                                        end
                                        global.get 2
                                        i64.xor
                                        global.set 2
                                      end
                                      global.get 2
                                      i64.xor
                                      global.set 2
                                      global.get 2
                                      i64.xor
                                      global.set 2
                                    end
                                    i64.reinterpret_f64
                                    global.get 1
                                    i64.xor
                                    global.set 1
                                    f32.const 0x1.55f52p+22 (;=5.60263e+06;)
                                  end
                                  i32.reinterpret_f32
                                  global.get 4
                                  i32.xor
                                  global.set 4
                                  global.get 2
                                  i64.xor
                                  global.set 2
                                  global.get 3
                                  i32.xor
                                  global.set 3
                                  i64.reinterpret_f64
                                  global.get 1
                                  i64.xor
                                  global.set 1
                                end
                                global.get 2
                                i64.xor
                                global.set 2
                                i32.const 639243223
                              end
                              global.get 3
                              i32.xor
                              global.set 3
                              i64.reinterpret_f64
                              global.get 1
                              i64.xor
                              global.set 1
                            end
                            i64.reinterpret_f64
                            global.get 1
                            i64.xor
                            global.set 1
                            global.get 2
                            i64.xor
                            global.set 2
                          end
                          i32.reinterpret_f32
                          global.get 4
                          i32.xor
                          global.set 4
                          global.get 2
                          i64.xor
                          global.set 2
                          global.get 2
                          i64.xor
                          global.set 2
                          i64.reinterpret_f64
                          global.get 1
                          i64.xor
                          global.set 1
                          global.get 3
                          i32.xor
                          global.set 3
                          global.get 2
                          i64.xor
                          global.set 2
                          global.get 2
                          i64.xor
                          global.set 2
                          i32.reinterpret_f32
                          global.get 4
                          i32.xor
                          global.set 4
                          i64.reinterpret_f64
                          global.get 1
                          i64.xor
                          global.set 1
                          global.get 3
                          i32.xor
                          global.set 3
                        end
                        i64.reinterpret_f64
                        global.get 1
                        i64.xor
                        global.set 1
                        global.get 3
                        i32.xor
                        global.set 3
                        i64.reinterpret_f64
                        global.get 1
                        i64.xor
                        global.set 1
                        global.get 2
                        i64.xor
                        global.set 2
                        i32.reinterpret_f32
                        global.get 4
                        i32.xor
                        global.set 4
                      end
                      f32.const -0x1.5022fp-76 (;=-1.73778e-23;)
                    end
                    i32.reinterpret_f32
                    global.get 4
                    i32.xor
                    global.set 4
                  end
                  global.get 2
                  i64.xor
                  global.set 2
                  i32.const 1926101505
                end
                global.get 3
                i32.xor
                global.set 3
              end
              f64.const 0x1.aa1e1ecfa64a1p+945 (;=4.95035e+284;)
            end
            i64.reinterpret_f64
            global.get 1
            i64.xor
            global.set 1
          end
          global.get 2
          i64.xor
          global.set 2
          global.get 3
          i32.xor
          global.set 3
          i32.reinterpret_f32
          global.get 4
          i32.xor
          global.set 4
          i64.reinterpret_f64
          global.get 1
          i64.xor
          global.set 1
          global.get 2
          i64.xor
          global.set 2
          global.get 2
          i64.xor
          global.set 2
          global.get 2
          i64.xor
          global.set 2
          i64.reinterpret_f64
          global.get 1
          i64.xor
          global.set 1
        end
        i64.reinterpret_f64
        global.get 1
        i64.xor
        global.set 1
        global.get 2
        i64.xor
        global.set 2
      end
      f32.const 0x1.f45a3p-4 (;=0.122156;)
    end
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4
    i64.const 8793433408872022375)
  (func (;6;) (type 0) (param i64) (result i64)
    (local f32 f64 f64 i32)
    f32.const 0x1.7d54f8p-35 (;=4.33524e-11;)
    local.get 2
    loop (result f64)  ;; label = @1
      i64.const -2053662370908916156
      i64.const 2491986974982453916
      local.get 0
      i32.const -1299846394
      br_table 1 (;@0;) 1 (;@0;)
      f32.const -0x1.9a6a1ap-94 (;=-8.094e-29;)
      i32.trunc_sat_f32_s
      i32.extend16_s
      loop (result i32)  ;; label = @2
        global.get 0
        f64.ceil
        f64.trunc
        i32.trunc_f64_s
        br 0 (;@2;)
        i64.load16_s offset=1369018528
        i64.extend16_s
        f64.const -0x1.decf26062d7b7p-764 (;=-1.92755e-230;)
        f64.floor
        i64.trunc_sat_f64_u
        i64.shr_s
        i64.extend8_s
        i64.clz
        i64.extend16_s
        f32.convert_i64_s
        i32.trunc_sat_f32_s
        i64.load16_s offset=166458
        i64.const -2030277541514266891
        i64.eq
        i32.load offset=791096 align=1
        i64.load8_s offset=1037096
        i32.const -2021910165
        f64.convert_i32_u
        loop (result i64)  ;; label = @3
          local.get 2
          i32.const -1590088899
          f32.load offset=651417 align=2
          i64.const -1641870142416428247
          global.get 0
          i32.trunc_f64_s
          i32.popcnt
          br 0 (;@3;)
          i32.eqz
          i64.load offset=1008844
          f32.convert_i64_u
          f32.neg
          f32.const -0x1.e4d9aep-50 (;=-1.68216e-15;)
          f32.add
          f32.abs
          loop  ;; label = @4
          end
          f32.abs
          i32.reinterpret_f32
          i32.load8_u offset=885285
          i64.extend_i32_s
          f32.const -0x1.3c781cp+38 (;=-3.39806e+11;)
          local.set 1
          i64.eqz
          if (param i64) (result i64)  ;; label = @4
            f64.convert_i64_s
            local.tee 3
            block  ;; label = @5
              global.get 0
              block (result i64)  ;; label = @6
                f32.const 0x1.95e4bap-114 (;=7.63401e-35;)
                i32.trunc_f32_s
                f64.convert_i32_s
                i64.trunc_f64_u
                i32.wrap_i64
                i32.load8_s offset=732715
                f32.load offset=935900 align=1
                i32.const -539598017
                i64.load8_s offset=498347
                f64.convert_i64_s
                f64.floor
                block  ;; label = @7
                  f32.const 0x1.6b7b5cp-12 (;=0.000346643;)
                  br 2 (;@5;)
                  nop
                  i32.const 1647041309
                  br_table 0 (;@7;) 2 (;@5;) 4 (;@3;) 5 (;@2;) 6 (;@1;) 0 (;@7;)
                  local.set 1
                  block (result i32)  ;; label = @8
                    i64.const 4347547936352326862
                    br 6 (;@2;)
                    local.set 0
                    f64.const 0x1.527bb716c9a7dp-53 (;=1.46794e-16;)
                    memory.size
                    i32.load offset=49478
                    br_table 1 (;@7;) 3 (;@5;) 5 (;@3;) 6 (;@2;) 7 (;@1;) 5 (;@3;)
                    f64.floor
                    br 1 (;@7;)
                    i64.reinterpret_f64
                    call 2
                    i32.const 974134101
                    i64.load8_u offset=952482
                    call 1
                    f32.convert_i64_u
                    local.tee 1
                    i32.trunc_sat_f32_u
                    local.tee 4
                    local.set 4
                    loop (result f64)  ;; label = @9
                      local.get 1
                      f32.nearest
                      local.set 1
                      br 8 (;@1;)
                      global.get 0
                      memory.size
                      f32.reinterpret_i32
                      f32.nearest
                      i64.trunc_sat_f32_u
                      i32.wrap_i64
                      memory.grow
                      i64.load32_s offset=218403359 align=2
                      local.set 0
                      f64.abs
                      f32.demote_f64
                      i32.trunc_sat_f32_u
                      i32.extend8_s
                      f32.convert_i32_u
                      f32.trunc
                      global.get 0
                      f64.neg
                      i32.trunc_sat_f64_u
                      i64.load offset=313326 align=2
                      local.tee 0
                      local.tee 0
                      loop (result i64)  ;; label = @10
                        block (result i32)  ;; label = @11
                          memory.size
                          br 6 (;@5;)
                          memory.size
                          i32.lt_u
                          local.tee 4
                          f64.convert_i32_u
                          f64.sqrt
                          block  ;; label = @12
                            memory.size
                            i64.load16_s offset=532917 align=1
                            local.get 1
                            loop  ;; label = @13
                              block  ;; label = @14
                                loop  ;; label = @15
                                  i32.const -388763348
                                  i32.load8_s offset=1020523
                                  i64.load8_s offset=3880569052
                                  i64.clz
                                  i64.const -472571601480124462
                                  call 9
                                  i64.rem_s
                                  block (param i64) (result i64)  ;; label = @16
                                    i64.ctz
                                    i64.ctz
                                    memory.size
                                    f64.load offset=861751
                                    global.get 0
                                    f64.copysign
                                    f32.demote_f64
                                    f32.const 0x1.86d0a2p+39 (;=8.39269e+11;)
                                    f32.max
                                    f64.const -0x1.5dbc83196221fp-870 (;=-1.73542e-262;)
                                    f64.ceil
                                    f32.demote_f64
                                    local.get 3
                                    loop  ;; label = @17
                                      memory.size
                                      f64.convert_i32_s
                                      f64.const -0x1.dbe265e6c88d4p-840 (;=-2.53551e-253;)
                                      f64.ge
                                      i32.load8_s offset=994587
                                      i64.load8_u offset=587494
                                      global.get 0
                                      memory.size
                                      br_if 16 (;@1;)
                                      i64.reinterpret_f64
                                      local.tee 0
                                      i32.const -1784007748
                                      i32.load offset=346324 align=2
                                      br_if 1 (;@16;)
                                      f64.reinterpret_i64
                                      f64.ceil
                                      global.get 0
                                      f64.floor
                                      f64.max
                                      f64.neg
                                      f64.sqrt
                                      i64.trunc_sat_f64_u
                                      i64.clz
                                      loop  ;; label = @18
                                        loop  ;; label = @19
                                          i32.const -832468719
                                          local.set 4
                                          block  ;; label = @20
                                            f32.const -0x1.0f3c76p-75 (;=-2.80452e-23;)
                                            br 2 (;@18;)
                                            memory.size
                                            i32.load8_s offset=140067581
                                            memory.grow
                                            i32.load8_u offset=362762
                                            memory.grow
                                            i64.load32_s offset=858451
                                            f32.convert_i64_u
                                            loop (result i32)  ;; label = @21
                                              f64.const 0x1.0d8e21d3abcbep-301 (;=2.58452e-91;)
                                              f64.ceil
                                              memory.size
                                              br 8 (;@13;)
                                              i32.load8_u offset=489939
                                              local.set 4
                                              local.set 3
                                              f32.const 0x1.c9784ap-17 (;=1.36337e-05;)
                                              i32.reinterpret_f32
                                              global.get 4
                                              i32.xor
                                              global.set 4
                                              i32.const 2018925251
                                            end
                                            global.get 3
                                            i32.xor
                                            global.set 3
                                            i32.reinterpret_f32
                                            global.get 4
                                            i32.xor
                                            global.set 4
                                            i32.reinterpret_f32
                                            global.get 4
                                            i32.xor
                                            global.set 4
                                          end
                                        end
                                      end
                                      global.get 2
                                      i64.xor
                                      global.set 2
                                      global.get 2
                                      i64.xor
                                      global.set 2
                                    end
                                    i64.reinterpret_f64
                                    global.get 1
                                    i64.xor
                                    global.set 1
                                    i32.reinterpret_f32
                                    global.get 4
                                    i32.xor
                                    global.set 4
                                    i32.reinterpret_f32
                                    global.get 4
                                    i32.xor
                                    global.set 4
                                  end
                                  global.get 2
                                  i64.xor
                                  global.set 2
                                end
                              end
                            end
                            i32.reinterpret_f32
                            global.get 4
                            i32.xor
                            global.set 4
                            global.get 2
                            i64.xor
                            global.set 2
                          end
                          i64.reinterpret_f64
                          global.get 1
                          i64.xor
                          global.set 1
                          i32.const -387351231
                        end
                        global.get 3
                        i32.xor
                        global.set 3
                        i64.const 2316308668082613009
                      end
                      global.get 2
                      i64.xor
                      global.set 2
                      global.get 2
                      i64.xor
                      global.set 2
                      i32.reinterpret_f32
                      global.get 4
                      i32.xor
                      global.set 4
                      f64.const 0x1.ded52d7416055p+102 (;=9.48426e+30;)
                    end
                    i64.reinterpret_f64
                    global.get 1
                    i64.xor
                    global.set 1
                    global.get 2
                    i64.xor
                    global.set 2
                    i32.const -820236517
                  end
                  global.get 3
                  i32.xor
                  global.set 3
                end
                i64.reinterpret_f64
                global.get 1
                i64.xor
                global.set 1
                i32.reinterpret_f32
                global.get 4
                i32.xor
                global.set 4
                i64.const 9120992212709075321
              end
              global.get 2
              i64.xor
              global.set 2
              i64.reinterpret_f64
              global.get 1
              i64.xor
              global.set 1
            end
            i64.reinterpret_f64
            global.get 1
            i64.xor
            global.set 1
            i64.const 7684093494146600151
          end
          global.get 2
          i64.xor
          global.set 2
          i32.reinterpret_f32
          global.get 4
          i32.xor
          global.set 4
          i64.reinterpret_f64
          global.get 1
          i64.xor
          global.set 1
          i64.const 9063773186402733423
        end
        global.get 2
        i64.xor
        global.set 2
        i64.reinterpret_f64
        global.get 1
        i64.xor
        global.set 1
        global.get 2
        i64.xor
        global.set 2
        i32.const -272633020
      end
      global.get 3
      i32.xor
      global.set 3
      global.get 3
      i32.xor
      global.set 3
      global.get 2
      i64.xor
      global.set 2
      global.get 2
      i64.xor
      global.set 2
      f64.const -0x1.47d71cbef27ap+639 (;=-2.92139e+192;)
    end
    i64.reinterpret_f64
    global.get 1
    i64.xor
    global.set 1
    i64.reinterpret_f64
    global.get 1
    i64.xor
    global.set 1
    i32.reinterpret_f32
    global.get 4
    i32.xor
    global.set 4
    i64.const -3797676960086213430)
  (func (;7;) (type 0) (param i64) (result i64)
    i32.const 930948487
    i64.extend_i32_s
    f64.const -0x1.1999701a627c7p-431 (;=-1.98364e-130;)
    i64.trunc_sat_f64_s
    memory.size
    i32.eqz
    i32.extend8_s
    local.get 0
    f64.convert_i64_s
    i64.trunc_f64_s
    local.get 0
    f64.const 0x1.8a1ecfa30c151p+356 (;=2.25979e+107;)
    i32.trunc_f64_s
    i32.clz
    f64.convert_i32_s
    loop  ;; label = @1
      i32.const -1145327014
      local.get 0
      f32.convert_i64_u
      i64.trunc_f32_u
      call 5
      i64.const -3452174579006077179
      global.get 0
      f64.sqrt
      block  ;; label = @2
        br 0 (;@2;)
        block  ;; label = @3
          global.get 0
          f32.const 0x1.af987p-1 (;=0.84296;)
          f32.ceil
          local.get 0
          drop
          call 4
          i64.const 9097118850665168405
          local.tee 0
          i64.gt_s
          i32.popcnt
          global.get 3
          i32.xor
          global.set 3
          i32.reinterpret_f32
          global.get 4
          i32.xor
          global.set 4
          i64.reinterpret_f64
          global.get 1
          i64.xor
          global.set 1
        end
      end
      i64.reinterpret_f64
      global.get 1
      i64.xor
      global.set 1
      global.get 2
      i64.xor
      global.set 2
      global.get 2
      i64.xor
      global.set 2
      global.get 3
      i32.xor
      global.set 3
    end
    i64.reinterpret_f64
    global.get 1
    i64.xor
    global.set 1
    global.get 2
    i64.xor
    global.set 2
    global.get 2
    i64.xor
    global.set 2
    global.get 3
    i32.xor
    global.set 3
    global.get 2
    i64.xor
    global.set 2)
  (func (;8;) (type 0) (param i64) (result i64)
    (local i32 i64 i32)
    local.get 1
    i32.load16_u offset=559770
    i32.load16_u offset=1026854
    i64.load32_u offset=269609
    f64.reinterpret_i64
    loop (result i32)  ;; label = @1
      global.get 0
      i64.trunc_f64_s
      block  ;; label = @2
        i32.const -1066791348
        memory.grow
        f32.const 0x1.18739cp+5 (;=35.0564;)
        f32.neg
        i64.trunc_sat_f32_u
        f64.reinterpret_i64
        nop
        i32.trunc_f64_u
        i32.popcnt
        memory.size
        i32.popcnt
        i32.add
        i64.load8_s offset=1047274
        br 2 (;@0;)
        block (result i64)  ;; label = @3
          loop  ;; label = @4
            loop (result f32)  ;; label = @5
              i32.const -1068546482
              block  ;; label = @6
                f64.const -0x1.31bdfd1dd4a81p+599 (;=-2.47789e+180;)
                i64.trunc_f64_s
                call 1
                local.get 2
                global.get 2
                i64.xor
                global.set 2
                global.get 2
                i64.xor
                global.set 2
              end
              global.get 3
              i32.xor
              global.set 3
              f32.const -0x1.46dcb2p+45 (;=-4.49236e+13;)
            end
            i32.reinterpret_f32
            global.get 4
            i32.xor
            global.set 4
          end
          i64.const 6118683426765177693
        end
        global.get 2
        i64.xor
        global.set 2
        global.get 3
        i32.xor
        global.set 3
      end
      global.get 2
      i64.xor
      global.set 2
      i32.const 91359444
    end
    global.get 3
    i32.xor
    global.set 3
    i64.reinterpret_f64
    global.get 1
    i64.xor
    global.set 1
    i64.const -6145861571263853290)
  (func (;9;) (type 0) (param i64) (result i64)
    (local i64 f32 f64)
    i32.const 2083411609
    local.get 1
    local.set 0
    block  ;; label = @1
      f32.const 0x1.821e7ap-104 (;=7.43638e-32;)
      local.set 2
      loop  ;; label = @2
        i64.const 5957389206469907181
        block  ;; label = @3
          f32.const 0x1.daf0e6p+95 (;=7.34936e+28;)
          f32.ceil
          f32.neg
          f64.const -0x1.fc294e1fe4d57p-922 (;=-5.59894e-278;)
          global.get 0
          i64.const -5492253946221840507
          f64.const 0x1.6cf32f5ac724ep-999 (;=2.66089e-301;)
          global.set 0
          memory.size
          i64.load32_s offset=989530
          i64.rotl
          local.tee 1
          i64.popcnt
          f32.const 0x1.3da944p-124 (;=5.83451e-38;)
          i32.trunc_f32_u
          i64.load8_s offset=2800376474
          f64.const 0x1.c3fe200ef0b79p+106 (;=1.43242e+32;)
          i64.const 7536939322327009783
          i64.eqz
          f64.const 0x1.3d473e41f6e7cp-571 (;=1.60351e-172;)
          i64.trunc_f64_u
          local.get 0
          local.get 1
          i64.ge_u
          br_table 0 (;@3;) 1 (;@2;) 2 (;@1;) 2 (;@1;)
          local.tee 0
          br 3 (;@0;)
          block (result f64)  ;; label = @4
            global.get 0
            i64.trunc_sat_f64_s
            memory.size
            i32.load8_u offset=207896
            i32.eqz
            i32.extend16_s
            i64.extend_i32_s
            block (param i64) (result i64)  ;; label = @5
              loop (result i32)  ;; label = @6
                f64.const -0x1.182d1ded793d5p+354 (;=-4.01615e+106;)
                i64.trunc_f64_u
                block  ;; label = @7
                  global.get 0
                  nop
                  i32.trunc_f64_u
                  memory.grow
                  i64.extend_i32_u
                  loop (param i64) (result i64)  ;; label = @8
                    f32.const -0x1.30366cp+15 (;=-38939.2;)
                    local.set 2
                    nop
                  end
                  i64.const -5856905585216810643
                  br 7 (;@0;)
                  f32.convert_i64_s
                  i32.trunc_f32_u
                  f64.load offset=850941
                  i64.trunc_f64_s
                  block  ;; label = @8
                  end
                  f32.const 0x1.33b638p+14 (;=19693.6;)
                  i32.reinterpret_f32
                  i32.extend8_s
                  i32.load8_s offset=90470
                  f32.convert_i32_u
                  f32.const 0x1.f5435cp+101 (;=4.96427e+30;)
                  f32.gt
                  f64.convert_i32_s
                  i32.const 394706493
                  f32.reinterpret_i32
                  f64.promote_f32
                  f64.lt
                  block (result i32)  ;; label = @8
                    global.get 0
                    local.tee 3
                    f64.abs
                    loop (result i64)  ;; label = @9
                      i32.const 1517285615
                      br_table 0 (;@9;) 2 (;@7;) 3 (;@6;) 6 (;@3;) 7 (;@2;) 8 (;@1;) 8 (;@1;)
                      br 7 (;@2;)
                      memory.size
                      i64.load32_s offset=810542 align=2
                      f64.reinterpret_i64
                      global.get 0
                      nop
                      global.set 0
                      global.get 0
                      local.set 3
                      loop (result i64)  ;; label = @10
                        global.get 0
                        local.get 2
                        f32.trunc
                        br 8 (;@2;)
                        i32.trunc_sat_f32_u
                        i64.load16_s offset=508023
                        f64.reinterpret_i64
                        i64.trunc_sat_f64_s
                        memory.size
                        f64.convert_i32_s
                        i64.trunc_sat_f64_s
                        i64.div_u
                        call 0
                        i64.extend32_s
                        f64.reinterpret_i64
                        i32.const 2089278732
                        i64.extend_i32_u
                        i64.extend32_s
                        f64.convert_i64_s
                        f64.const 0x1.7a384ae9f287fp+469 (;=2.25202e+141;)
                        block (result f32)  ;; label = @11
                          global.get 0
                          f32.const 0x1.38922cp-6 (;=0.0190778;)
                          local.get 1
                          f32.convert_i64_s
                          loop  ;; label = @12
                            memory.size
                            f32.const -0x1.1cbbbp-37 (;=-8.0926e-12;)
                            i32.const 645943612
                            i32.load16_s offset=290535696 align=1
                            f64.const -0x1.343365b17696bp+677 (;=-7.5492e+203;)
                            i32.const -460683755
                            global.get 0
                            f32.demote_f64
                            memory.size
                            f32.load offset=981893 align=2
                            f32.gt
                            f32.convert_i32_s
                            i32.trunc_f32_s
                            i32.and
                            i32.load offset=496633258 align=2
                            memory.size
                            i32.shl
                            global.get 0
                            f32.const -0x1.0b7618p-62 (;=-2.26549e-19;)
                            i64.trunc_f32_u
                            block (param i64) (result i64)  ;; label = @13
                              i32.const 1712586567
                              i64.load32_u offset=177188 align=2
                              f64.reinterpret_i64
                              i64.reinterpret_f64
                              block (param i64) (result i64)  ;; label = @14
                                i32.const 2009246534
                                memory.grow
                                i32.const 59661506
                                f32.convert_i32_u
                                local.tee 2
                                f32.abs
                                f32.const -0x1.eb8166p+56 (;=-1.38346e+17;)
                                memory.size
                                i64.load8_u offset=758727
                                i64.extend8_s
                                f32.convert_i64_u
                                memory.size
                                memory.grow
                                f64.convert_i32_s
                                block  ;; label = @15
                                  loop  ;; label = @16
                                    i64.const 7973865536599848017
                                    local.get 2
                                    global.get 0
                                    f32.const 0x1.a4a286p+23 (;=1.37834e+07;)
                                    f64.const -0x1.ece7fa5cc1719p-973 (;=-2.41178e-293;)
                                    i32.trunc_f64_u
                                    i32.load8_u offset=1805560561
                                    i64.load32_u offset=36683
                                    f64.convert_i64_u
                                    f32.const -0x1.1f6362p-105 (;=-2.76745e-32;)
                                    f64.const -0x1.e7ace57035201p-569 (;=-9.85878e-172;)
                                    i64.const -8972334792331191186
                                    i64.ctz
                                    global.get 0
                                    global.set 0
                                    f64.convert_i64_s
                                    memory.size
                                    br_table 0 (;@16;) 1 (;@15;) 4 (;@12;) 6 (;@10;) 7 (;@9;) 9 (;@7;) 10 (;@6;) 13 (;@3;) 14 (;@2;) 15 (;@1;) 14 (;@2;)
                                    br 13 (;@3;)
                                    local.set 3
                                    local.set 3
                                    i32.trunc_sat_f32_u
                                    i64.load32_u offset=174737666 align=2
                                    i64.popcnt
                                    local.set 0
                                    f64.nearest
                                    i64.trunc_f64_u
                                    i64.extend8_s
                                    f32.convert_i64_u
                                    f32.lt
                                    i64.extend_i32_u
                                    f32.convert_i64_s
                                    f32.neg
                                    i32.trunc_f32_s
                                    block  ;; label = @17
                                      local.get 1
                                      loop (param i64) (result i64)  ;; label = @18
                                        f32.convert_i64_u
                                        i32.const 947067139
                                        i64.load16_u offset=104776
                                        f64.const 0x1.9e552a40a4fffp-872 (;=5.13988e-263;)
                                        br 11 (;@7;)
                                        i64.trunc_sat_f64_u
                                        i64.eqz
                                        i32.popcnt
                                        block (result f32)  ;; label = @19
                                          i64.const 618166273652658030
                                          local.get 2
                                          f32.neg
                                          i32.reinterpret_f32
                                          br_table 1 (;@18;) 5 (;@14;) 6 (;@13;) 14 (;@5;) 19 (;@0;) 1 (;@18;)
                                          i32.const 2130513483
                                          i32.eqz
                                          f64.convert_i32_u
                                          br 10 (;@9;)
                                          local.tee 3
                                          global.set 0
                                          i32.const 1508545380
                                          i64.load8_s offset=1750818652
                                          local.tee 0
                                          call 7
                                          i32.wrap_i64
                                          i64.load16_u offset=911222 align=1
                                          f32.convert_i64_u
                                          block  ;; label = @20
                                            global.get 0
                                            f32.const -0x1.955c6ap+41 (;=-3.48202e+12;)
                                            f32.sqrt
                                            i32.trunc_f32_u
                                            loop  ;; label = @21
                                              block  ;; label = @22
                                                br 6 (;@16;)
                                                f64.const 0x1.38cebcb583a15p+846 (;=5.73342e+254;)
                                                f64.const 0x1.2ca5085c4f77dp-273 (;=7.73793e-83;)
                                                f64.trunc
                                                f32.const -0x1.75c0cep-4 (;=-0.0912483;)
                                                i32.trunc_f32_u
                                                f32.const -0x1.b42592p-10 (;=-0.00166377;)
                                                f32.nearest
                                                i64.trunc_sat_f32_u
                                                i64.store32 offset=528831 align=2
                                                f64.add
                                                i64.trunc_f64_u
                                                f64.const 0x1.5bd084793bc96p-525 (;=1.23697e-158;)
                                                global.set 0
                                                br 5 (;@17;)
                                                call 3
                                                global.get 0
                                                f64.floor
                                                i64.trunc_f64_u
                                                i64.le_u
                                                f32.convert_i32_u
                                                i32.trunc_sat_f32_u
                                                f64.const 0x1.0755647afd434p-343 (;=5.74087e-104;)
                                                i64.trunc_f64_u
                                                f64.reinterpret_i64
                                                local.set 3
                                                i32.load8_u offset=2954303496
                                                i64.load8_u offset=434375
                                                f64.convert_i64_u
                                                i32.trunc_sat_f64_u
                                                block (result f32)  ;; label = @23
                                                  memory.size
                                                  br_table 1 (;@22;) 2 (;@21;) 3 (;@20;) 6 (;@17;) 7 (;@16;) 8 (;@15;) 11 (;@12;) 13 (;@10;) 14 (;@9;) 16 (;@7;) 17 (;@6;) 20 (;@3;) 21 (;@2;) 22 (;@1;) 3 (;@20;)
                                                  br 13 (;@10;)
                                                  f64.const -0x1.0162142194243p+32 (;=-4.31817e+09;)
                                                  f32.const -0x1.7c47bep+20 (;=-1.55763e+06;)
                                                  f32.sqrt
                                                  f32.ceil
                                                  f32.const -0x1.90ff42p-45 (;=-4.45196e-14;)
                                                  f32.max
                                                  local.get 0
                                                  local.set 1
                                                  i64.trunc_sat_f32_s
                                                  global.get 0
                                                  i32.trunc_sat_f64_u
                                                  i32.load8_s offset=904141
                                                  nop
                                                  i64.load16_u offset=883879
                                                  memory.size
                                                  i64.extend_i32_s
                                                  i64.shr_s
                                                  i64.ge_s
                                                  i64.extend_i32_s
                                                  local.set 0
                                                  i32.trunc_sat_f64_s
                                                  i32.load offset=857501 align=1
                                                  i64.load8_u offset=667287
                                                  i32.const -237291362
                                                  i64.load32_u offset=743412
                                                  f32.convert_i64_u
                                                  memory.size
                                                  f32.const -0x1.e2276ep+35 (;=-6.47136e+10;)
                                                  memory.size
                                                  i64.load16_s offset=413902
                                                  i32.const -1805981452
                                                  i32.extend8_s
                                                  i64.extend_i32_s
                                                  i64.shl
                                                  local.get 0
                                                  local.get 0
                                                  block (param i64) (result i64)  ;; label = @24
                                                    f32.convert_i64_s
                                                    br 3 (;@21;)
                                                    i64.trunc_f32_u
                                                    f64.const -0x1.4ded55183828cp-304 (;=-4.00215e-92;)
                                                    local.get 0
                                                    global.get 0
                                                    i32.trunc_sat_f64_u
                                                    local.get 3
                                                    i32.trunc_sat_f64_s
                                                    i32.and
                                                    i32.load8_s offset=1018059
                                                    f32.convert_i32_s
                                                    i32.trunc_sat_f32_u
                                                    memory.size
                                                    i32.store offset=992206 align=2
                                                    br 12 (;@12;)
                                                    f64.reinterpret_i64
                                                    f64.neg
                                                    f64.ceil
                                                    f64.add
                                                    i32.trunc_sat_f64_s
                                                    loop  ;; label = @25
                                                      f32.const -0x1.29c85p-105 (;=-2.86754e-32;)
                                                      block (result f32)  ;; label = @26
                                                        f64.const -0x1.09b90d2351315p-907 (;=-9.59363e-274;)
                                                        global.set 0
                                                        loop (result f64)  ;; label = @27
                                                          i32.const -1076301367
                                                          i64.const -751158078024859418
                                                          call 9
                                                          i64.extend16_s
                                                          memory.size
                                                          i32.eqz
                                                          br 5 (;@22;)
                                                          i32.load8_u offset=179845
                                                          i64.load8_s offset=825845
                                                          i64.eqz
                                                          f64.convert_i32_u
                                                          f32.demote_f64
                                                          f32.ceil
                                                          f32.abs
                                                          global.get 0
                                                          f64.trunc
                                                          i32.trunc_f64_u
                                                          f32.reinterpret_i32
                                                          loop (result f32)  ;; label = @28
                                                            f32.const -0x1.8aeb8ep-98 (;=-4.86777e-30;)
                                                            i64.trunc_sat_f32_u
                                                            loop (result f32)  ;; label = @29
                                                              memory.size
                                                              local.get 2
                                                              memory.size
                                                              i64.load32_s offset=3344500660 align=1
                                                              local.set 1
                                                              i32.const 132544108
                                                              block (result f64)  ;; label = @30
                                                                br 14 (;@16;)
                                                                f32.const 0x1.4e48dap-96 (;=1.64815e-29;)
                                                                i32.const -1539258055
                                                                i32.extend8_s
                                                                f64.load offset=2669398992 align=2
                                                                f32.demote_f64
                                                                br 11 (;@19;)
                                                                br 7 (;@23;)
                                                                i32.const 465107902
                                                                memory.size
                                                                i32.extend8_s
                                                                i32.clz
                                                                i32.xor
                                                                i32.load8_u offset=137647
                                                                i64.load8_u offset=278789
                                                                f64.const 0x1.70f621920af5fp-822 (;=5.15329e-248;)
                                                                f64.abs
                                                                local.set 3
                                                                f32.convert_i64_u
                                                                i64.trunc_sat_f32_u
                                                                i32.wrap_i64
                                                                br_if 8 (;@22;)
                                                                i32.const -575404995
                                                                i64.load32_u offset=751429070 align=1
                                                                global.get 0
                                                                global.get 0
                                                                global.set 0
                                                                i32.trunc_sat_f64_u
                                                                f64.convert_i32_u
                                                                f64.abs
                                                                global.set 0
                                                                i64.eqz
                                                                f64.convert_i32_u
                                                                f32.demote_f64
                                                                i64.trunc_sat_f32_u
                                                                call 6
                                                                f64.const -0x1.8c6019a87ab8dp-352 (;=-1.68775e-106;)
                                                                f32.const -0x1.2c2312p+4 (;=-18.7586;)
                                                                br 18 (;@12;)
                                                                i32.const 1463138112
                                                                if (result i64)  ;; label = @31
                                                                  f32.const 0x1.c4120ap-51 (;=7.84217e-16;)
                                                                  loop  ;; label = @32
                                                                    f64.const -0x1.6fc0d208e0f14p-624 (;=-2.06347e-188;)
                                                                    f64.floor
                                                                    local.tee 3
                                                                    f64.floor
                                                                    i64.reinterpret_f64
                                                                    i64.const 3741505921991954882
                                                                    br 32 (;@0;)
                                                                    return
                                                                    i32.const 1863547097
                                                                    i32.eqz
                                                                    i64.extend_i32_s
                                                                    br 19 (;@13;)
                                                                    local.get 0
                                                                    global.get 0
                                                                    i32.trunc_f64_s
                                                                    i32.ctz
                                                                    i64.const 3808683095906496720
                                                                    f32.convert_i64_u
                                                                    loop  ;; label = @33
                                                                      i32.const 466423258
                                                                      i64.load8_u offset=306345
                                                                      local.set 0
                                                                      i64.const -2577490901979941634
                                                                      block (result i32)  ;; label = @34
                                                                        local.get 2
                                                                        f32.const 0x1.46b55cp-77 (;=8.44522e-24;)
                                                                        f32.lt
                                                                        i64.load16_u offset=3048366335
                                                                        i64.extend32_s
                                                                        i32.const -2045102662
                                                                        loop  ;; label = @35
                                                                          global.get 0
                                                                          global.set 0
                                                                          local.get 2
                                                                          f64.const -0x1.04aca44627ef4p-139 (;=-1.46113e-42;)
                                                                          f32.const 0x1.9a4ef4p-104 (;=7.90225e-32;)
                                                                          f32.neg
                                                                          i64.trunc_f32_s
                                                                          i64.clz
                                                                          f64.reinterpret_i64
                                                                          f64.max
                                                                          f64.trunc
                                                                          block  ;; label = @36
                                                                            local.get 0
                                                                            i32.wrap_i64
                                                                            i64.load16_u offset=89754 align=1
                                                                            i64.ctz
                                                                            i64.eqz
                                                                            i32.load16_u offset=283394
                                                                            i32.extend8_s
                                                                            i64.const 3421456565871756233
                                                                            memory.size
                                                                            i64.load32_s offset=517505 align=2
                                                                            f64.convert_i64_s
                                                                            br 19 (;@17;)
                                                                            local.set 3
                                                                            i64.ctz
                                                                            f32.convert_i64_u
                                                                            f32.sqrt
                                                                            br 27 (;@9;)
                                                                            i64.trunc_f32_u
                                                                            i32.const 1023238784
                                                                            nop
                                                                            i32.ctz
                                                                            i32.eqz
                                                                            f32.reinterpret_i32
                                                                            i32.reinterpret_f32
                                                                            loop (result f32)  ;; label = @37
                                                                              loop (result f64)  ;; label = @38
                                                                                f64.const -0x1.eade486a90d0ep+307 (;=-4.99958e+92;)
                                                                              end
                                                                              i64.reinterpret_f64
                                                                              global.get 1
                                                                              i64.xor
                                                                              global.set 1
                                                                              f32.const 0x1.d03728p-103 (;=1.78809e-31;)
                                                                            end
                                                                            i32.reinterpret_f32
                                                                            global.get 4
                                                                            i32.xor
                                                                            global.set 4
                                                                            global.get 3
                                                                            i32.xor
                                                                            global.set 3
                                                                            global.get 2
                                                                            i64.xor
                                                                            global.set 2
                                                                            global.get 3
                                                                            i32.xor
                                                                            global.set 3
                                                                          end
                                                                          i64.reinterpret_f64
                                                                          global.get 1
                                                                          i64.xor
                                                                          global.set 1
                                                                          i32.reinterpret_f32
                                                                          global.get 4
                                                                          i32.xor
                                                                          global.set 4
                                                                        end
                                                                        global.get 3
                                                                        i32.xor
                                                                        global.set 3
                                                                        global.get 2
                                                                        i64.xor
                                                                        global.set 2
                                                                        i32.const 1526145013
                                                                      end
                                                                      global.get 3
                                                                      i32.xor
                                                                      global.set 3
                                                                      drop
                                                                    end
                                                                    i32.reinterpret_f32
                                                                    global.get 4
                                                                    i32.xor
                                                                    global.set 4
                                                                    global.get 3
                                                                    i32.xor
                                                                    global.set 3
                                                                    global.get 2
                                                                    i64.xor
                                                                    global.set 2
                                                                  end
                                                                  i32.reinterpret_f32
                                                                  global.get 4
                                                                  i32.xor
                                                                  global.set 4
                                                                  i64.const -1860574401055318360
                                                                else
                                                                  i64.const 8954884609404490819
                                                                end
                                                                global.get 2
                                                                i64.xor
                                                                global.set 2
                                                                i32.reinterpret_f32
                                                                global.get 4
                                                                i32.xor
                                                                global.set 4
                                                                i64.reinterpret_f64
                                                                global.get 1
                                                                i64.xor
                                                                global.set 1
                                                                global.get 2
                                                                i64.xor
                                                                global.set 2
                                                                f64.const 0x1.b0eb47037e3ap-509 (;=1.00902e-153;)
                                                              end
                                                              i64.reinterpret_f64
                                                              global.get 1
                                                              i64.xor
                                                              global.set 1
                                                              global.get 3
                                                              i32.xor
                                                              global.set 3
                                                              i32.reinterpret_f32
                                                              global.get 4
                                                              i32.xor
                                                              global.set 4
                                                              global.get 3
                                                              i32.xor
                                                              global.set 3
                                                              f32.const 0x1.8a7f0ap-2 (;=0.38525;)
                                                            end
                                                            i32.reinterpret_f32
                                                            global.get 4
                                                            i32.xor
                                                            global.set 4
                                                            global.get 2
                                                            i64.xor
                                                            global.set 2
                                                            f32.const 0x1.f1ce6ap-16 (;=2.96716e-05;)
                                                          end
                                                          i32.reinterpret_f32
                                                          global.get 4
                                                          i32.xor
                                                          global.set 4
                                                          i32.reinterpret_f32
                                                          global.get 4
                                                          i32.xor
                                                          global.set 4
                                                          i32.reinterpret_f32
                                                          global.get 4
                                                          i32.xor
                                                          global.set 4
                                                          global.get 2
                                                          i64.xor
                                                          global.set 2
                                                          global.get 3
                                                          i32.xor
                                                          global.set 3
                                                          f64.const -0x1.48554240301bdp+250 (;=-2.32046e+75;)
                                                        end
                                                        i64.reinterpret_f64
                                                        global.get 1
                                                        i64.xor
                                                        global.set 1
                                                        f32.const 0x1.b259b8p+96 (;=1.34425e+29;)
                                                      end
                                                      drop
                                                      i32.reinterpret_f32
                                                      global.get 4
                                                      i32.xor
                                                      global.set 4
                                                    end
                                                    global.get 3
                                                    i32.xor
                                                    global.set 3
                                                  end
                                                  global.get 2
                                                  i64.xor
                                                  global.set 2
                                                  global.get 2
                                                  i64.xor
                                                  global.set 2
                                                  global.get 2
                                                  i64.xor
                                                  global.set 2
                                                  i32.reinterpret_f32
                                                  global.get 4
                                                  i32.xor
                                                  global.set 4
                                                  global.get 3
                                                  i32.xor
                                                  global.set 3
                                                  i32.reinterpret_f32
                                                  global.get 4
                                                  i32.xor
                                                  global.set 4
                                                  global.get 2
                                                  i64.xor
                                                  global.set 2
                                                  f32.const -0x1.55bddcp-13 (;=-0.000162955;)
                                                end
                                                i32.reinterpret_f32
                                                global.get 4
                                                i32.xor
                                                global.set 4
                                                global.get 3
                                                i32.xor
                                                global.set 3
                                              end
                                            end
                                            global.get 3
                                            i32.xor
                                            global.set 3
                                            i64.reinterpret_f64
                                            global.get 1
                                            i64.xor
                                            global.set 1
                                          end
                                        end
                                        i32.reinterpret_f32
                                        global.get 4
                                        i32.xor
                                        global.set 4
                                        global.get 3
                                        i32.xor
                                        global.set 3
                                        global.get 2
                                        i64.xor
                                        global.set 2
                                        i32.reinterpret_f32
                                        global.get 4
                                        i32.xor
                                        global.set 4
                                        i64.const -3174304214227045506
                                      end
                                      global.get 2
                                      i64.xor
                                      global.set 2
                                    end
                                    global.get 3
                                    i32.xor
                                    global.set 3
                                    i64.reinterpret_f64
                                    global.get 1
                                    i64.xor
                                    global.set 1
                                    i32.reinterpret_f32
                                    global.get 4
                                    i32.xor
                                    global.set 4
                                    global.get 2
                                    i64.xor
                                    global.set 2
                                  end
                                end
                                i64.reinterpret_f64
                                global.get 1
                                i64.xor
                                global.set 1
                                i32.reinterpret_f32
                                global.get 4
                                i32.xor
                                global.set 4
                                i32.reinterpret_f32
                                global.get 4
                                i32.xor
                                global.set 4
                                i32.reinterpret_f32
                                global.get 4
                                i32.xor
                                global.set 4
                                global.get 3
                                i32.xor
                                global.set 3
                              end
                              global.get 2
                              i64.xor
                              global.set 2
                            end
                            global.get 2
                            i64.xor
                            global.set 2
                            i64.reinterpret_f64
                            global.get 1
                            i64.xor
                            global.set 1
                            global.get 3
                            i32.xor
                            global.set 3
                            i64.reinterpret_f64
                            global.get 1
                            i64.xor
                            global.set 1
                            global.get 3
                            i32.xor
                            global.set 3
                            i32.reinterpret_f32
                            global.get 4
                            i32.xor
                            global.set 4
                            global.get 3
                            i32.xor
                            global.set 3
                          end
                          i32.reinterpret_f32
                          global.get 4
                          i32.xor
                          global.set 4
                          i32.reinterpret_f32
                          global.get 4
                          i32.xor
                          global.set 4
                          i64.reinterpret_f64
                          global.get 1
                          i64.xor
                          global.set 1
                          f32.const -0x1.c5748ap-93 (;=-1.78857e-28;)
                        end
                        i32.reinterpret_f32
                        global.get 4
                        i32.xor
                        global.set 4
                        i64.reinterpret_f64
                        global.get 1
                        i64.xor
                        global.set 1
                        i64.reinterpret_f64
                        global.get 1
                        i64.xor
                        global.set 1
                        i64.reinterpret_f64
                        global.get 1
                        i64.xor
                        global.set 1
                        i64.reinterpret_f64
                        global.get 1
                        i64.xor
                        global.set 1
                        i64.const -5645545540544642427
                      end
                      global.get 2
                      i64.xor
                      global.set 2
                      i64.reinterpret_f64
                      global.get 1
                      i64.xor
                      global.set 1
                      i64.const 2570152516695370069
                    end
                    global.get 2
                    i64.xor
                    global.set 2
                    i64.reinterpret_f64
                    global.get 1
                    i64.xor
                    global.set 1
                    i32.const -1363131517
                  end
                  global.get 3
                  i32.xor
                  global.set 3
                  global.get 3
                  i32.xor
                  global.set 3
                  global.get 2
                  i64.xor
                  global.set 2
                end
                global.get 2
                i64.xor
                global.set 2
                i32.const 1317597553
              end
              global.get 3
              i32.xor
              global.set 3
            end
            global.get 2
            i64.xor
            global.set 2
            global.get 2
            i64.xor
            global.set 2
            f64.const 0x1.fadb3106b7f24p-363 (;=1.0538e-109;)
          end
          i64.reinterpret_f64
          global.get 1
          i64.xor
          global.set 1
          global.get 3
          i32.xor
          global.set 3
          i64.reinterpret_f64
          global.get 1
          i64.xor
          global.set 1
          global.get 2
          i64.xor
          global.set 2
          global.get 2
          i64.xor
          global.set 2
          i64.reinterpret_f64
          global.get 1
          i64.xor
          global.set 1
          i64.reinterpret_f64
          global.get 1
          i64.xor
          global.set 1
          i32.reinterpret_f32
          global.get 4
          i32.xor
          global.set 4
        end
        global.get 2
        i64.xor
        global.set 2
      end
    end
    global.get 3
    i32.xor
    global.set 3
    i64.const 892550371011848228)
  (memory (;0;) 16 60404)
  (global (;0;) (mut f64) (f64.const 0x1.a40622e6b0a61p+190 (;=2.57474e+57;)))
  (global (;1;) (mut i64) (i64.const 0))
  (global (;2;) (mut i64) (i64.const 0))
  (global (;3;) (mut i32) (i32.const 0))
  (global (;4;) (mut i32) (i32.const 0))
  (export "s" (func 0))
  (export "" (func 1))
  (export "2" (func 2))
  (export "3" (func 3))
  (export "main" (func 4))
  (export "5" (func 5))
  (export "6" (func 6))
  (export "7" (func 7))
  (export "8" (func 8))
  (export "9" (func 9))
  (export "10" (memory 0))
  (export "11" (global 0))
  (export "d\10" (global 1))
  (export "13" (global 2))
  (export "14" (global 3))
  (export "15" (global 4)))
