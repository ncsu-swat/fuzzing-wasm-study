from extract_dump import at_least_one_can_instantiate
from file_util import check_dir, cp_file
from .tester_util import testerExecInfo
from .tester_util import test_one_tc
from .tester_util import post_process_arrording_to_diff_reason
from .tester import Tester
from generate_tcs_by_mutation_util import generate_tcs_by_mutate_bytes
from random import random
from file_util import remove_file_without_exception
from pathlib import Path

import subprocess
import os
import time

class randomByteMutationTester(Tester):
    def __init__(self, one_tc_limit=50, mutate_num=5, mutate_prob=1) -> None:
        self.one_tc_limit = one_tc_limit
        self.mutate_num = mutate_num
        self.mutate_prob = mutate_prob

    def run_testing(self, exec_paths, impls, tc_paths_iterator, start_time, time_limit):
        exec_info, can_init_tc_paths = testing_without_mutation_and_collect_can_init_tc(exec_paths, impls, tc_paths_iterator, start_time, time_limit)
        exec_info.mutation_ori_tc_num = len(can_init_tc_paths)
        for ori_seed in can_init_tc_paths:
            if time.time() - start_time > time_limit:
                break

            self.cur_seed_mutant_num = 0
            self.possible_m = []
            if random() < self.mutate_prob:
                self.mutate_and_update_log(exec_paths, exec_info, ori_seed)
            while self.possible_m:
                if time.time() - start_time > time_limit:
                    break

                try:
                    tc_path = self.possible_m.pop()
                    tc_name = Path(tc_path).stem
                    tc_dumped_data_dir = check_dir(exec_paths.dumped_data_base_dir / tc_name)
                    # dumped_results, difference_reason = test_one_tc(tc_dumped_data_dir, impls, tc_path)
                    exec_info.all_exec_times += 1
                    can_instantiate_ = wasm_validate(tc_path) # at_least_one_can_instantiate(dumped_results)
                    if can_instantiate_:
                        exec_info.at_least_one_to_analyze += 1
                    if self._need_mutate(can_instantiate_):
                        self.mutate_and_update_log(exec_paths, exec_info, tc_path)

                    # post_process_arrording_to_diff_reason(exec_paths, tc_dumped_data_dir, exec_info, tc_path, tc_name, difference_reason)
                    # assert Path(tc_path).parent == exec_paths.new_tc_dir
                    # remove_file_without_exception(tc_path)
                except (RuntimeError, Exception) as e:
                    cp_file(tc_path, exec_paths.except_dir)
        return exec_info

    def __repr__(self):
        return self._common_brief_info(**{
            'one_tc_limit': self.one_tc_limit,
            'mutate_num': self.mutate_num,
            'mutate_prob': self.mutate_prob
        })

    def mutate_and_update_log(self, exec_paths, exec_info, tc_path):
        self.cur_seed_mutant_num += self.mutate_num
        self.possible_m.extend(self.generate_tcs(tc_path, exec_paths.new_tc_dir))
        exec_info.mutation_times += self.mutate_num

    def generate_tcs(self, ori_tc, new_tc_dir):
        return generate_tcs_by_mutate_bytes(ori_tc, self.mutate_num, new_tc_dir)

    def _need_mutate(self, can_instantiate_):
        if can_instantiate_:
            if self.one_tc_limit > self.cur_seed_mutant_num:
                return True
        return False


def testing_without_mutation_and_collect_can_init_tc(exec_paths, impls, tc_paths_iterator, start_time, time_limit):
    exec_info = testerExecInfo()
    can_init_tc_paths = []
    for tc_name, tc_path in tc_paths_iterator:
        if time.time() - start_time > time_limit:
            break

        try:
            exec_info.ori_tc_num += 1
            tc_dumped_data_dir = check_dir(exec_paths.dumped_data_base_dir / tc_name)
            # dumped_results, difference_reason = test_one_tc(tc_dumped_data_dir, impls, tc_path)
            can_instantiate_ = True # wasm_validate(tc_path) # at_least_one_can_instantiate(dumped_results)
            exec_info.all_exec_times += 1
            if can_instantiate_:
                exec_info.at_least_one_to_analyze += 1
                can_init_tc_paths.append(tc_path)
            # post_process_arrording_to_diff_reason(exec_paths, tc_dumped_data_dir, exec_info, tc_path, tc_name, difference_reason)
        except (RuntimeError, Exception) as e:
            # raise e
            cp_file(tc_path, exec_paths.except_dir)
    return exec_info, can_init_tc_paths

def wasm_validate(tc_path=None):
  is_valid = True

  if tc_path:
    try:
      result = subprocess.run(
        ['timeout', '5s', 'wasm-tools', 'validate', tc_path],
        stdout = subprocess.PIPE,
        stderr = subprocess.STDOUT,
        text = True,
        check = False
      )
    except Exception as e:
      print(f"wasm_validate error inside random_byte_mutation_tester: {e}")
      is_valid = False

    if not result or 'error' in result.stdout:
      is_valid = False

  # if not is_valid:
  #   os.remove(tc_path)

  return is_valid
