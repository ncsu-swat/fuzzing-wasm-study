#!/bin/bash

# Configuring the shell to prevent expansion of empty directories
shopt -s nullglob

postprocess_wasmtime() {
  local output="$1"
  if [[ "$output" == *"warning: using"* ]]; then
    output=${output//"warning: using \`--invoke\` with a function that returns values is experimental and may break in the future"/}
  elif [[ "$output" == *"out of bounds"* ]]; then
    echo "out of bounds"
    return
  elif [[ "$output" == *"call stack exhausted"* ]]; then
    echo "stack overflow"
    return
  elif [[ "$output" == *"unknown import:"* ]]; then
    echo "unknown import"
    return
  elif [[ "$output" == *"invalid conversion to integer"* ]]; then
    echo "invalid conversion to integer"
    return
  elif [[ "$output" == *"integer overflow"* ]]; then
    echo "integer overflow"
    return
  elif [[ "$output" == *"undefined element"* ]]; then
    echo "undefined element"
    return
  elif [[ "$output" == *"uninitialized element"* ]]; then
    echo "uninitialized element"
    return
  elif [[ "$output" == *"unreachable"* ]]; then
    echo "unreachable"
    return
  elif [[ "$output" == *"integer divide by zero"* ]]; then
    echo "integer divide by zero"
    return
  elif [[ "$output" == *"type mismatch"* ]]; then
    echo "type mismatch"
    return
  elif [[ "$output" == *"missing required memory export"* ]]; then
    echo "export memory error"
    return
  fi
  echo "$output"
}
export -f postprocess_wasmtime

postprocess_wasmer() {
  local output="$1"
  if [[ "$output" != *"error"* ]]; then
    :
  elif [[ "$output" == *"out of bounds"* ]]; then
    echo "out of bounds"
    return
  elif [[ "$output" == *"call stack exhausted"* ]]; then
    echo "stack overflow"
    return
  elif [[ "$output" == *"unknown import"* ]]; then
    echo "unknown import"
    return
  elif [[ "$output" == *"invalid conversion to integer"* ]]; then
    echo "invalid conversion to integer"
    return
  elif [[ "$output" == *"integer overflow"* ]]; then
    echo "integer overflow"
    return
  elif [[ "$output" == *"undefined element"* ]]; then
    echo "undefined element"
    return
  elif [[ "$output" == *"uninitialized element"* ]]; then
    echo "uninitialized element"
    return
  elif [[ "$output" == *"unreachable"* ]]; then
    echo "unreachable"
    return
  elif [[ "$output" == *"integer divide by zero"* ]]; then
    echo "integer divide by zero"
    return
  elif [[ "$output" == *"type mismatch"* ]]; then
    echo "type mismatch"
    return
  fi
  echo "$output"
}
export -f postprocess_wasmer

postprocess_wamrc() {
  local output="$1"
  if [[ "$output" == *"Compile success"* ]]; then
    echo "compilation_successful"
  else
    echo "compilation_failed"
  fi
}
export -f postprocess_wamrc

postprocess_wamr() {
  local output="$1"
  # if [[ "$output" =~ :[ifv] ]]; then
  #   temp=""
  #   IFS=","
  #   for val in $output; do
  #     if [[ "$val" =~ :v128 ]]; then
  #       v128_temp="${val//:v128/}"
  #       v128_temp="${v128_temp//</}"
  #       v128_temp="${v128_temp//>/}"
  #       declare -a words
  #       IFS=' ' read -r -a words <<< "$v128_temp"
  #       unset IFS && IFS=','
  #       temp+=${words[1]}"${words[0]//0x/} "
  #     else
  #       temp_replacement="${val//:i32/}"
  #       temp_replacement="${temp_replacement//:i64/}"
  #       temp_replacement="${temp_replacement//:f32/}"
  #       temp_replacement="${temp_replacement//:f64/}"
  #       temp+=$temp_replacement" "
  #     fi
  #   done
  #   unset IFS
  #   echo "$temp"
  #   return
  if [[ "$output" == *"data segment does not fit"* ]]; then
    echo "data segment does not fit"
    return
  elif [[ "$output" == *"out of bounds"* ]]; then
    echo "out of bounds"
    return
  elif [[ "$output" == *"stack overflow"* ]]; then
    echo "stack overflow"
    return
  elif [[ "$output" == *"failed to link import"* ]]; then
    echo "failed to link import"
    return
  elif [[ "$output" == *"invalid conversion to integer"* ]]; then
    echo "invalid conversion to integer"
    return
  elif [[ "$output" == *"integer overflow"* ]]; then
    echo "integer overflow"
    return
  elif [[ "$output" == *"undefined element"* ]]; then
    echo "undefined element"
    return
  elif [[ "$output" == *"uninitialized element"* ]]; then
    echo "uninitialized element"
    return
  elif [[ "$output" == *"unreachable"* ]]; then
    echo "unreachable"
    return
  elif [[ "$output" == *"integer divide by zero"* ]]; then
    echo "integer divide by zero"
    return
  elif [[ "$output" == *"type mismatch"* ]]; then
    echo "type mismatch"
    return
  elif [[ "$output" == *"must export memory"* ]]; then
    echo "export memory error"
    return
  elif [[ "$output" == *"Segmentation fault"* ]]; then
    echo "Segmentation fault"
    return
  elif [[ "$output" == *"Aborted"* ]]; then
    echo "Aborted"
    return
  elif [[ "$output" == *"timeout"* ]]; then
    echo "timeout"
    return
  fi
  echo "$output"
}
export -f postprocess_wamr

postprocess_wasmedge() {
  local output="$1"
  if [[ "$output" == *"out of bounds"* ]]; then
    echo "out of bounds"
    return
  elif [[ "$output" == *"unknown import"* ]]; then
    echo "unknown import"
    return
  elif [[ "$output" == *"invalid conversion to integer"* ]]; then
    echo "invalid conversion to integer"
    return
  elif [[ "$output" == *"integer overflow"* ]]; then
    echo "integer overflow"
    return
  elif [[ "$output" == *"undefined element"* ]]; then
    echo "undefined element"
    return
  elif [[ "$output" == *"uninitialized element"* ]]; then
    echo "uninitialized element"
    return
  elif [[ "$output" == *"unreachable"* ]]; then
    echo "unreachable"
    return
  elif [[ "$output" == *"integer divide by zero"* ]]; then
    echo "integer divide by zero"
    return
  elif [[ "$output" == *"type mismatch"* ]]; then
    echo "type mismatch"
    return
  elif [[ "$output" == *"malformed section id"* ]]; then
    echo "malformed section id"
    return
  elif [[ "$output" == *"must export memory"* ]]; then
    echo "export memory error"
    return
  fi
  echo "$output"
}
export -f postprocess_wasmedge

postprocess_common() {
  local runtime="$1"
  local output="$2"
  case "$runtime" in
    *wasmtime*) postprocess_wasmtime "$output" ;;
    *wasmer*) postprocess_wasmer "$output" ;;
    *wamrc*) postprocess_wamrc "$output" ;;
    *iwasm*) postprocess_wamr "$output" ;;
    *wasmedge*) postprocess_wasmedge "$output" ;;
    *) echo "Unsupported runtime: $runtime" ;;
  esac
}
export -f postprocess_common

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

# ======================================

ref_trace() {
  cmd=$1
  target_output=$2

  prog_path="$(echo $cmd | tail -n 1 | awk '{print $1}')"
  prog_ref_args="$(echo $cmd | tail -n 1 | awk '{$1=""; sub(/^ /, ""); print}')"
  ref_trace_output_file="output/ref_trace.txt"
  PYTHONPATH=$(lldb -P) python3 diff_trace.py --program="$prog_path" --args="$prog_ref_args" --target-output="$target_output" --output="$ref_trace_output_file"
  ref_trace=`cat "$ref_trace_output_file"`

  echo $ref_trace
}
export -f ref_trace

test_trace() {
  cmd=$1
  target_output=$2

  prog_path="$(echo $cmd | tail -n 1 | awk '{print $1}')"
  prog_args="$(echo $cmd | tail -n 1 | awk '{$1=""; sub(/^ /, ""); print}')"
  trace_output_file="output/temp_trace.txt"
  PYTHONPATH=$(lldb -P) python3 diff_trace.py --program="$prog_path" --args="$prog_args" --target-output="$target_output" --output="$trace_output_file"
  trace=`cat "$trace_output_file"`

  echo $trace
}
export -f test_trace

triage() {
  ref_cmd=$1
}
export -f triage

# ======================================

# Main
cmdfile="$1"
diff_config_file="diffs.json"
runtime=`cat /identity/runtime.txt`
bugnum=`cat /identity/bugnum.txt`

readarray -t pre < <(jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].pre[]' $diff_config_file)
cmd=`jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].cmd' $diff_config_file`
error=`jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].error' $diff_config_file`
expected=`jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].expected' $diff_config_file`
readarray -t testcmd < <(jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].test_cmd[]' $diff_config_file)
readarray -t oraclecmd < <(jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].oracle_cmd[]' $diff_config_file)
timeout_s=`jq -r --arg runtime "$runtime" --arg bugnum "$bugnum" '.[$runtime][$bugnum].timeout' $diff_config_file`

# echo "Pre: ${pre[@]}"
# echo "Command: $cmd"
# echo "Error: $error"
# echo "Test Command: ${testcmd[@]}"
# echo "Oracle Command: ${oraclecmd[@]}"
# echo "Timeout: $timeout_s"

# Satisfy preconditions
for pre_cmd in "${pre[@]}"; do
  _pre_cmd="${pre_cmd//<bugnum>/$bugnum}"
  eval "$_pre_cmd"
done

rm -rf output 2&>/dev/null && mkdir -p output

fuzzers=("WaDiff" "Wapplique" "WASMaker" "WasmSmith")
# fuzzers=("wasmtime")

echo -e "\n============================================================================"
echo -e "Bug: $bugnum"
echo -e "============================================================================\n"

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
      _oraclecmd="${oraclecmd[i]//<testcase>/$testcase}"

      echo "TESTCMD: $_testcmd"
      echo "ORACLECMD: $_oraclecmd"
      
      test_out=$(run_command "$_testcmd" "$timeout_s")
      echo "TESTOUT: $test_out"

      if [[ "$_oraclecmd" != *"#"* ]]; then
        oracle_out=$(run_command "$_oraclecmd" "$timeout_s")
        echo "ORACLEOUT: $oracle_out"

        if [ -z "$error" ]; then
          # check against expected
          if [[ "$test_out" != *"$expected"* && "$oracle_out" == *"$expected"* ]]; then
            echo -e "\nMatch"
            # shortlist for later triage
            echo "$_testcmd" > $shortlist_path/$testcase_filename.txt
          fi
        else
          # check against error
          if [[ "$test_out" == *"$error"* && "$oracle_out" != *"$error"* ]]; then
            echo -e "\nMatch"
            # shortlist for later triage
            echo "$_testcmd" > $shortlist_path/$testcase_filename.txt
          fi
        fi
      else
        echo "ORACLEOUT: ignored"
      fi
    done
  done
done
