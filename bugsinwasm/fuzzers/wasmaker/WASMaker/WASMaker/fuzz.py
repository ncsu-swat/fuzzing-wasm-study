# WASMaker/fuzz.py
import subprocess, sys, time, os, json, traceback
from WASMaker.fuzzer.module_generator import *
from WASMaker.settings import *

time_limit = sys.argv[1]  # minutes

sys.setrecursionlimit(100000)

# output dir under the repo (not /testcases at filesystem root)
OUT_DIR = "/testcases"
os.makedirs(OUT_DIR, exist_ok=True)

JSONL_PATH = os.path.join(os.getcwd(), "provenance.jsonl")
JSON_ARRAY_PATH = os.path.join(os.getcwd(), "provenance.json")

# fuzz window
end_time = time.time() + (int(time_limit) * 60)

# load ASTs
avail_ASTs = get_avail_ASTs()
if not avail_ASTs:
    print("ERROR: avail_ASTs is empty. Did preprocessing run in THIS environment? Is Mongo reachable?")
    # optional: exit early so you see the problem
    sys.exit(1)

# at least one non-empty bucket
if all(not bucket for bucket in avail_ASTs):
    print("ERROR: All AST buckets are empty.")
    sys.exit(1)

i = 0
while time.time() < end_time:
    try:
        filename = os.path.join(OUT_DIR, f"test{i + 1}_{time.time()}.wasm")
        emit_wasm_bianry(filename, avail_ASTs, AST_mutation=True, module_mutation=True)
        print(f"test{i + 1}_{time.time()}.wasm generated successfully")
        i += 1
    except Exception as e:
        print(f"\nWASMaker exception: {e!r}")
        traceback.print_exc()
        break  # stop on first failure to debug

print(f"Fuzzing finished. Generated: {i} number of test cases")

# consolidate JSONL -> JSON array
try:
    entries = []
    if os.path.exists(JSONL_PATH):
        with open(JSONL_PATH, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line:
                    try:
                        entries.append(json.loads(line))
                    except Exception:
                        pass
    tmp = JSON_ARRAY_PATH + ".tmp"
    with open(tmp, "w", encoding="utf-8") as out:
        json.dump(entries, out, indent=2)
        out.flush(); os.fsync(out.fileno())
    os.replace(tmp, JSON_ARRAY_PATH)
    print(f"Wrote consolidated provenance: {JSON_ARRAY_PATH} ({len(entries)} items)")
except Exception as e:
    print(f"Failed to write {JSON_ARRAY_PATH}: {e!r}")
