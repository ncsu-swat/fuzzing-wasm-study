#!/bin/bash

# Configuring the shell to prevent expansion of empty directories
shopt -s nullglob

run_command() {
  local cmd="$1"
  local timeout_s="$2"
  local cmdname="${cmd%% *}"
  
  local output
  output=$(timeout -s SIGKILL --foreground $timeout_s bash -c "$cmd" & 2>&1)
  local exit_status=$?

  if [[ $exit_status -eq 124 ]]; then
    # Exit code 124 indicates the timeout was reached
    output="timeout"
  elif [[ $exit_status -eq 139 ]]; then
    if [[ -z "$output" || "$output" == *"dumped core"* ]]; then
      output="Segmentation fault"
    fi
  elif [[ $exit_status -eq 134 ]]; then
    if [[ -z "$output" || "$output" == *"dumped core"* ]]; then
      output="Aborted"
    fi
  elif [[ $exit_status -eq 132 ]]; then
    if [[ -z "$output" || "$output" == *"dumped core"* ]]; then
      output="Illegal instruction"
    fi
  elif [[ $exit_status -ne 0 ]]; then
    # echo "Error: Command failed"
    :
  fi

  postprocess_common "$cmdname" "$output"
}
export -f run_command

# ==================================================================================================================

get_progpath() {
  cmd="$1"
  prog_path="$(echo $cmd | tail -n 1 | awk '{print $1}')"

  echo "$prog_path"
}

get_progargs() {
  cmd="$1"
  prog_ref_args="$(echo $cmd | tail -n 1 | awk '{$1=""; sub(/^ /, ""); print}')"

  echo "$prog_ref_args"
}

get_progpathfilter() {
  prog_path="$1"

  prog_path_filter=""
  if [[ $prog_path == "wasmtime" ]]; then
    prog_path_filter="/wasmtime"
  elif [[ $prog_path == "wasmer" ]]; then
    prog_path_filter="/wasmer"
  elif [[ $prog_path == "iwasm" ]]; then
    prog_path_filter="/wasm-micro-runtime"
  elif [[ $prog_path == "wasmedge" ]]; then
    prog_path_filter="/WasmEdge"
  fi

  echo "$prog_path_filter"
}

ref_trace() {
  cmd="$1"
  bugnum="$2"

  prog_path=$(get_progpath "$cmd")
  prog_ref_args=$(get_progargs "$cmd")
  prog_path_filter=$(get_progpathfilter "$prog_path")
  trace_out_file="$bugnum-ref.txt"

  # echo $prog_path
  # echo $prog_ref_args
  # echo $prog_path_filter
  # echo $trace_out_file

  bash trace.sh "$prog_path" "$prog_ref_args" "$prog_path_filter" "$trace_out_file"
  ref_trace=$(cat $trace_out_file)
  
  echo "$ref_trace"
}
export -f ref_trace

test_trace() {
  cmd="$1"
  cmdtemplate="$2"
  bugnum="$3"

  prog_path=$(get_progpath "$cmd")
  prog_test_args=$(get_progargs "$cmdtemplate")
  prog_path_filter=$(get_progpathfilter "$prog_path")
  trace_out_file="$bugnum-$fuzzer-$testcase_filename.txt"

  bash trace.sh "$prog_path" "$prog_test_args" "$prog_path_filter" "$trace_out_file"
  test_trace=$(cat $trace_out_file)
  
  echo "$test_trace"
}
export -f test_trace

# ==================================================================================================================

# Main
cmdfile="$1"
crash_config_file="crashes.json"
runtime=`cat /identity/runtime.txt`
bugnum=`cat /identity/bugnum.txt`

readarray -t pre < <(jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].pre[]' $diff_config_file)
cmd=`jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].cmd' $diff_config_file`
error=`jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].error' $diff_config_file`
readarray -t testcmd < <(jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].test_cmd[]' $diff_config_file)
timeout_s=`jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].timeout' $diff_config_file`

# echo "Pre: ${pre[@]}"
# echo "Command: $cmd"
# echo "Error: $error"
# echo "Test Command: ${testcmd[@]}"
# echo "Timeout: $timeout_s"

# Satisfy preconditions
for pre_cmd in "${pre[@]}"; do
  _pre_cmd="${pre_cmd//<bugnum>/$bugnum}"
  eval "$_pre_cmd"
done

rm -rf output 2&>/dev/null && mkdir -p output

# ==================================================================================================================

# fuzzers=("WaDiff" "Wapplique" "WASMaker" "WasmSmith")
fuzzers=("WASMaker")

echo -e "\n============================================================================"
echo -e "Bug: $bugnum"
echo -e "============================================================================\n"

# Generate reference stack trace only once at the beginning
ref_trace=$(ref_trace "$cmd" "$bugnum")

# run testcases from each fuzzer
echo -e "\n============================================================================"
echo -e "\n RUNNING FUZZ-CASES"
echo -e "\n============================================================================"

for fuzzer in "${fuzzers[@]}"; do
  shortlist_path="/repro/output/$fuzzer"
  mkdir -p $shortlist_path
  for testcase in /testcases/$fuzzer/*.wasm; do
    testcase_filename="${testcase##*/}"
    testcase_filename="${testcase_filename/.wasm/}"
    
    echo -e "\nTestcase: $testcase_filename\n"
    for i in "${!testcmd[@]}"; do
      _testcmd="${testcmd[i]//<testcase>/$testcase}"
      # echo "TESTCMD: $_testcmd"
      test_out=$(run_command "$_testcmd" "$timeout_s")
      # echo "TESTOUT: $test_out"

      if [[ "$test_out" == *"Aborted"* || "$test_out" == *"Segmentation fault"* || "$test_out" == *"panic"* ]]; then
        echo -e "\nMatch"
        
        # # shortlist for later triage
        # echo "$_testcmd" > $shortlist_path/$testcase_filename.txt

        test_trace=$(test_trace "$cmd" "$_testcmd" "$bugnum")

        if [[ "$ref_trace" == "$test_trace" ]]; then
          echo $test_out > /repro/output/$bugnum/$fuzzer/$testcase_filename.txt
          echo -e "\nTrace:\n$test_trace" >> /repro/output/$bugnum/$fuzzer/$testcase_filename.txt
          echo -e "\nTrace match. Reproduction successful.\n"
        fi
      fi
    done
  done
done