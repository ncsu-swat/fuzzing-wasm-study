#!/bin/bash

# Configuring the shell to prevent expansion of empty directories
shopt -s nullglob

run_command() {
  local cmd="$1"
  local cmdname="${cmd%% *}"
  
  local output
  output=$(timeout -s SIGKILL --foreground 10 bash -c "$cmd" 2>&1)
  local exit_status=$?

  if [[ $exit_status -eq 124 ]]; then
    # Exit code 124 indicates the timeout was reached
    output="timeout"
  elif [[ $exit_status -eq 139 ]]; then
    output="Segmentation fault"
  elif [[ $exit_status -eq 134 ]]; then
    output="Aborted"
  elif [[ $exit_status -ne 0 ]]; then
    # echo "Error: Command failed"
    :
  fi

  echo "$output"
}
export -f run_command

# Main
cmdfile="$1"

rm -rf output 2&>/dev/null && mkdir -p output

# fuzzers=("WaDiff" "Wapplique" "WASMaker")
fuzzers=("WASMaker")

for bug in /bugs/*; do
  echo -e "\n============================================================================"
  echo -e "Bug: $bug"
  echo -e "============================================================================\n"

  bugnum="${bug##*/}"

  mkdir -p /repro/output/$bugnum

  # satisfy preconditions if any
  if [ -f "$bug/pre.sh" ]; then
    bash "$bug/pre.sh"
  fi

  # set variables for running trace.sh later
  prog_path="$(cat $bug/cmd.txt | tail -n 1 | awk '{print $1}')"
  prog_ref_args="$(cat $bug/cmd.txt | tail -n 1 | awk '{$1=""; sub(/^ /, ""); print}')"
  prog_path_filter=""
  trace_out_file="$bugnum-ref.txt"
  if [[ $prog_path == "wasmtime" ]]; then
    prog_path_filter="/wasmtime"
  elif [[ $prog_path == "wasmer" ]]; then
    prog_path_filter="/wasmer"
  elif [[ $prog_path == "iwasm" ]]; then
    prog_path_filter="/wasm-micro-runtime"
  elif [[ $prog_path == "wasmedge" ]]; then
    prog_path_filter="/WasmEdge"
  fi

  # generate reference stack trace
  ref_trace=""  

  # echo $prog_path
  # echo $prog_ref_args
  # echo $prog_path_filter
  # echo $trace_out_file

  bash trace.sh "$prog_path" "$prog_ref_args" "$prog_path_filter" "$trace_out_file"
  ref_trace=$(cat $trace_out_file)
  echo -e "\nREF TRACE:\n===========\n$ref_trace\n"

  # run testcases from each fuzzer
  echo -e "\n============================================================================"
  echo -e "\n RUNNING FUZZ-CASES"
  echo -e "\n============================================================================"

  for fuzzer in "${fuzzers[@]}"; do
    mkdir -p /repro/output/$bugnum/$fuzzer
    for testcase in /testcases/$fuzzer/*.wasm; do
      testcase_filename="${testcase##*/}"
      testcase_filename="${testcase_filename/.wasm/}"
      
      echo -e "\nTestcase: $testcase_filename\n"
      while IFS= read -r line || [[ -n "$line" ]]; do
        cmdtemplate="${line//<testcase>/$testcase}"
        out=$(run_command "$cmdtemplate")

        if [[ "$out" == *"Aborted"* || "$out" == *"Segmentation fault"* || "$out" == *"panic"* ]]; then
          echo -e "\nMatch"

          # generate the stack trace for this test case
          prog_test_args=$(echo $cmdtemplate | tail -n 1 | awk '{$1=""; sub(/^ /, ""); print}')
          trace_out_file="$bugnum-$fuzzer-$testcase_filename.txt"

          bash trace.sh "$prog_path" "$prog_test_args" "$prog_path_filter" "$trace_out_file"
          trace=$(cat $trace_out_file)
          echo -e "\nTRACE:\n=======\n$trace\n"

          if [[ "$ref_trace" == "$trace" ]]; then
            echo $out > /repro/output/$bugnum/$fuzzer/$testcase_filename.txt
            echo -e "\nTrace:\n$trace" >> /repro/output/$bugnum/$fuzzer/$testcase_filename.txt
            echo -e "\nTrace match. Reproduction successful.\n"
          fi
        fi
      done < "$bug/cmdtemplate.txt"
    done
  done
done
