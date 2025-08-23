import subprocess
import sys
import time

from WASMaker.fuzzer.module_generator import *
from WASMaker.settings import *

time_limit = sys.argv[1] # (bugsinwasm: standardized across all fuzzers in minutes)

sys.setrecursionlimit(100000)

# set the fuzzing time
current_time = time.time()
end_time = current_time + (int(time_limit) * 60)

# get the available ASTs
avail_ASTs = get_avail_ASTs()

i = 0
while time.time() < end_time:
  try:
    # Generate the wasm binary
    AST_mutation = True
    module_mutation = True

    filename = f"/testcases/test{i + 1}.wasm"
    emit_wasm_bianry(filename, avail_ASTs, AST_mutation, module_mutation)
    print(f"test{i + 1}.wasm generated successfully")

    i += 1
  except Exception as e:
    print(f"WASMaker exception. Continuing.")

print(f"Fuzzing finished. Generated: {i} number of test cases")