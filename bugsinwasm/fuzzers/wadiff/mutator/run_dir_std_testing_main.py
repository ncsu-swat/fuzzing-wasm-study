import sys
from run_dir_testing import test_and_analyze
from run_dir_testing import mutationParas
from get_impls_util import get_std_impls

import time

if __name__ == '__main__':
    if len(sys.argv) != 5:
        print(f"Usage: python {sys.argv[0]} <tested_dir> <result_base_dir> <start_time> <time_limit>")
        print("  <tested_dir>:       Path to the directory containing test cases")
        print("  <result_base_dir>:  Path to store testing results")
        print("  <start_time>:       Start time as Unix timestamp (e.g., 1720281612.49)")
        print("  <time_limit>:       Time limit in minutes (e.g., 5)")
        sys.exit(1)

    tested_dir = sys.argv[1]
    result_base_dir = sys.argv[2]
    start_time = float(sys.argv[3])
    time_limit = int(sys.argv[4]) * 60

    impls = get_std_impls()
    paras = mutationParas.get_paras_with_mutation(
        tested_dir,
        result_base_dir,
        one_tc_limit=30,
        mutate_num=3,
        mutate_prob=1,
        impls=impls
    )

    # Keep generating
    while time.time() - start_time < time_limit:
      test_and_analyze(result_base_dir, paras, start_time, time_limit, impls=impls)
