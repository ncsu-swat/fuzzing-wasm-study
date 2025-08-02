#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem=120G
#SBATCH --cpus-per-task=120
#SBATCH --time=12:00:00
#SBATCH --output=logs/replaywasm.log

# Set recursion limit equivalent
ulimit -s unlimited

normalize_one_number() {
    if [[ $1 =~ ^-?[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?$ || $1 =~ ^(0x) ]]; then
        # Print the scientific notation number
        formatted=$(printf "%.6e" "$1")

        # Separate the mantissa and exponent
        mantissa="${formatted%e*}"
        exponent="${formatted#*e}"

        printf "%f %s " "$mantissa" "${exponent//\+/}"
    elif [[ $1 == "nan" || $1 == "-nan" ]]; then
        printf "NaN "
    else
        printf "%s " "$1"
    fi
}
export -f normalize_one_number

normalize_all_numbers() {
    local output="$1"
    while IFS= read -r line; do
        for val in $line; do
            normalize_one_number $val
        done
    done <<< "$output"
}
export -f normalize_all_numbers

postprocess_wasmtime() {
    local output="$1"
    if [[ "$output" == *"warning: using"* ]]; then
        output=${output//"warning: using \`--invoke\` with a function that returns values is experimental and may break in the future"/}
    elif [[ "$output" == *"fatal"* ]]; then
        echo "fatal"
        return
    elif [[ "$output" == *"out of bounds"* ]]; then
        echo "out_of_bounds"
        return
    elif [[ "$output" == *"call stack exhausted"* ]]; then
        echo "stack_overflow"
        return
    elif [[ "$output" == *"unknown import:"* ]]; then
        echo "import_error"
        return
    elif [[ "$output" == *"invalid conversion to integer"* ]]; then
        echo "invalid_conversion_to_integer"
        return
    elif [[ "$output" == *"integer overflow"* ]]; then
        echo "integer_overflow"
        return
    elif [[ "$output" == *"undefined element"* ]]; then
        echo "undefined_element"
        return
    elif [[ "$output" == *"uninitialized element"* ]]; then
        echo "uninitialized_element"
        return
    elif [[ "$output" == *"unreachable"* ]]; then
        echo "unreachable"
        return
    elif [[ "$output" == *"integer divide by zero"* ]]; then
        echo "integer_divide_by_zero"
        return
    elif [[ "$output" == *"type mismatch"* ]]; then
        echo "type_mismatch"
        return
    elif [[ "$output" == *"failed to parse"* ]]; then
        echo "invalid"
        return
    elif [[ "$output" == *"Pointer not aligned"* ]]; then
        echo "unaligned_pointer"
        return
    fi
    normalize_all_numbers "$output"
}
export -f postprocess_wasmtime

postprocess_wasmer() {
    local output="$1"
    if [[ "$output" == *"fatal"* ]]; then
        echo "fatal"
        return
    elif [[ "$output" == *"out of bounds"* ]]; then
        echo "out_of_bounds"
        return
    elif [[ "$output" == *"call stack exhausted"* ]]; then
        echo "stack_overflow"
        return
    elif [[ "$output" == *"unknown import"* ]]; then
        echo "import_error"
        return
    elif [[ "$output" == *"invalid conversion to integer"* ]]; then
        echo "invalid_conversion_to_integer"
        return
    elif [[ "$output" == *"integer overflow"* ]]; then
        echo "integer_overflow"
        return
    elif [[ "$output" == *"undefined element"* ]]; then
        echo "undefined_element"
        return
    elif [[ "$output" == *"uninitialized element"* ]]; then
        echo "uninitialized_element"
        return
    elif [[ "$output" == *"unreachable"* ]]; then
        echo "unreachable"
        return
    elif [[ "$output" == *"integer divide by zero"* ]]; then
        echo "integer_divide_by_zero"
        return
    elif [[ "$output" == *"type mismatch"* ]]; then
        echo "type_mismatch"
        return
    elif [[ "$output" == *"LLVM ERROR"* ]]; then
        if [[ "$output" == *"return type does not match"* ]]; then
            echo "llvm_error_ret_type_mismatch"
            return
        elif [[ "$output" == *"Cannot select"* ]]; then
            echo "llvm_error_cannot_select"
            return
        elif [[ "$output" == *"Incorrect number of arguments"* ]]; then
            echo "llvm_error_incorrect_nargs"
            return
        fi
        echo "llvm_error"
        return
    elif [[ "$output" == *"does not support"* ]]; then
        echo "unsupported"
        return
    fi
    normalize_all_numbers "$output"
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
    if [[ "$output" =~ :[ifv] ]]; then
        temp=""
        IFS=","
        for val in $output; do
            if [[ "$val" =~ :v128 ]]; then
                v128_temp="${val//:v128/}"
                v128_temp="${v128_temp//</}"
                v128_temp="${v128_temp//>/}"
                declare -a words
                IFS=' ' read -r -a words <<< "$v128_temp"
                unset IFS && IFS=','
                temp+=${words[1]}"${words[0]//0x/} "
            else
                temp_replacement="${val//:i32/}"
                temp_replacement="${temp_replacement//:i64/}"
                temp_replacement="${temp_replacement//:f32/}"
                temp_replacement="${temp_replacement//:f64/}"
                temp+=$temp_replacement" "
            fi
        done
        unset IFS
    elif [[ "$output" == *"fatal"* ]]; then
        echo "fatal"
        return
    elif [[ "$output" == *"does not fit"* || "$output" == *"out of bounds"* ]]; then
        echo "out_of_bounds"
        return
    elif [[ "$output" == *"stack overflow"* ]]; then
        echo "stack_overflow"
        return
    elif [[ "$output" == *"failed to link import"* ]]; then
        echo "import_error"
        return
    elif [[ "$output" == *"invalid conversion to integer"* ]]; then
        echo "invalid_conversion_to_integer"
        return
    elif [[ "$output" == *"integer overflow"* ]]; then
        echo "integer_overflow"
        return
    elif [[ "$output" == *"undefined element"* ]]; then
        echo "undefined_element"
        return
    elif [[ "$output" == *"uninitialized element"* ]]; then
        echo "uninitialized_element"
        return
    elif [[ "$output" == *"unreachable"* ]]; then
        echo "unreachable"
        return
    elif [[ "$output" == *"integer divide by zero"* ]]; then
        echo "integer_divide_by_zero"
        return
    elif [[ "$output" == *"type mismatch"* ]]; then
        echo "type_mismatch"
        return
    elif [[ "$output" == $"core dumped"* ]]; then
        echo "core_dumped"
        return
    elif [[ "$output" == *"timeout"* ]]; then
        echo "timeout"
        return
    elif [[ "$output" == *"load failed"* ]]; then
        if [[ "$output" == *"unexpected end"* ]]; then
            echo "invalid_unexpected_end"
            return
        elif [[ "$output" == *"find block end addr failed"* ]]; then
            echo "invalid_block_end_addr_failed"
            return
        elif [[ "$output" == *"invalid init expr type"* ]]; then
            echo "invalid_init_expr_type"
            return
        elif [[ "$output" == *"invalid memop flags"* ]]; then
            echo "invalid_memop_flags"
            return
        fi
        echo "invalid"
        return
    else
        echo "$output"
    fi
    normalize_all_numbers "$temp"
}
export -f postprocess_wamr

postprocess_wasmedge() {
    local output="$1"
    if [[ "$output" == *"fatal"* ]]; then
        echo "fatal"
        return
    elif [[ "$output" == *"out of bounds"* ]]; then
        echo "out_of_bounds"
        return
    elif [[ "$output" == *"unknown import"* ]]; then
        echo "import_error"
        return
    elif [[ "$output" == *"invalid conversion to integer"* ]]; then
        echo "invalid_conversion_to_integer"
        return
    elif [[ "$output" == *"integer overflow"* ]]; then
        echo "integer_overflow"
        return
    elif [[ "$output" == *"undefined element"* ]]; then
        echo "out_of_bounds"
        return
    elif [[ "$output" == *"uninitialized element"* ]]; then
        echo "uninitialized_element"
        return
    elif [[ "$output" == *"unreachable"* ]]; then
        echo "unreachable"
        return
    elif [[ "$output" == *"integer divide by zero"* ]]; then
        echo "integer_divide_by_zero"
        return
    elif [[ "$output" == *"type mismatch"* ]]; then
        echo "type_mismatch"
        return
    elif [[ "$output" == *"loading failed"* || "$output" == *"validation failed"* ]]; then
        echo "invalid"
        return
    elif [[ "$output" == *"not yet supported"* ]]; then
        echo "unsupported"
        return
    fi
    normalize_all_numbers "$output"
}
export -f postprocess_wasmedge

postprocess_common() {
    local runtime="$1"
    local output="$2"
    case "$runtime" in
        wasmtime) postprocess_wasmtime "$output" ;;
        wasmtimec) echo "$output" ;;
        wasmer) postprocess_wasmer "$output" ;;
        wamrc) postprocess_wamrc "$output" ;;
        wamr) postprocess_wamr "$output" ;;
        wasmedge) postprocess_wasmedge "$output" ;;
        wasmedgec) echo "$output" ;;
        *) echo "Unsupported runtime: $runtime" ;;
    esac
}
export -f postprocess_common

run_command() {
  local runtime="$1"
  local cmd="$2"
  # echo "Running: $cmd"
  
  local output
  output=$(timeout -s SIGKILL --foreground 10 bash -c "$cmd" 2>&1)
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

  # echo "$output"
  processed_output=$(postprocess_common "$runtime" "$output")
  echo "$exit_status:<>:$processed_output"
}
export -f run_command

delegate() {
  wasm_dir="$1"
  func_name="$2"
  wasm_file="$3"

  if [[ "$wasm_file" == *.wasm ]]; then
    # =======================================================================================================
    # Check validity of the wasm testcase
    # =======================================================================================================
    valid_or_invalid=$(wasm-tools validate "$wasm_file" 2>&1)
    if [[ "$valid_or_invalid" == *"error"* ]]; then
      return 0
    fi

    wasm_filename="${wasm_file##*/}"
    wasm_filename="${wasm_filename/.wasm/}"
    output_filename="$wasm_dir/output/$wasm_filename.txt"

    # =======================================================================================================
    # Skip if output file exists
    # =======================================================================================================
    if [ -e "$output_filename" ]; then
      return 0
    fi

    # =======================================================================================================
    # wasmtime
    # =======================================================================================================
    wasmtime_output=$(run_command "wasmtime" "RUST_LOG="" wasmtime run -W all-proposals=y --invoke $func_name $wasm_file")
    echo "wasmtime:  $wasmtime_output" >> $output_filename

    cwasm_file="$wasm_dir/tmpdir/$wasm_filename.cwasm"
    wasmtime_compile_output=$(run_command "wasmtimec" "RUST_LOG="" wasmtime compile -W all-proposals=y -o $cwasm_file $wasm_file")
    cwasm_output=""
    if [[ "$wasmtime_compile_output" == *"Error"* ]]; then
      cwasm_output="1:<>:"$(postprocess_wasmtime "$wasmtime_compile_output")
    else
      cwasm_output=$(run_command "wasmtime" "RUST_LOG="" wasmtime run --allow-precompiled -W all-proposals=y --invoke $func_name $cwasm_file")
    fi
    echo "wasmtime_compiled: $cwasm_output" >> $output_filename

    # =======================================================================================================
    # wasmer
    # =======================================================================================================
    # singlepass does not support simd instructions as of version 6.0.0 (so skipping)
    # wasmer_output=$(run_command "wasmer" "wasmer run --singlepass $wasm_file --invoke main")
    # echo "wasmer output:    $wasmer_output" >> $output_filename

    wasmer_output=$(run_command "wasmer" "RUST_LOG="" wasmer run --enable-simd --enable-threads --enable-verifier --enable-reference-types --enable-multi-value --enable-bulk-memory --enable-relaxed-simd --enable-extended-const --cranelift $wasm_file --invoke $func_name")
    echo "wasmer_cranelift:    $wasmer_output" >> $output_filename

    wasmer_output=$(run_command "wasmer" "RUST_LOG="" wasmer run --enable-simd --enable-threads --enable-verifier --enable-reference-types --enable-multi-value --enable-bulk-memory --enable-relaxed-simd --enable-extended-const --enable-exceptions --llvm $wasm_file --invoke $func_name")
    echo "wasmer_llvm:    $wasmer_output" >> $output_filename

    # =======================================================================================================
    # wamr
    # =======================================================================================================
    aot_file="$wasm_dir/tmpdir/$wasm_filename.aot"
    wamrc_output=$(run_command "wamrc" "wamrc --xip --enable-builtin-intrinsics=all --enable-multi-thread --bounds-checks=1 -o $aot_file $wasm_file")
    echo "wamr_compiler:     $wamrc_output" >> $output_filename

    wamr_output=""
    if [[ "$wamrc_output" == *"compilation_failed"* ]]; then
      wamr_output=$(run_command "wamr" "wamrc --xip --enable-builtin-intrinsics=all --enable-multi-thread --bounds-checks=1 -o $aot_file $wasm_file")
    else
      wamr_output=$(run_command "wamr" "iwasm --heap-size=0 -f $func_name $aot_file")
    fi
    echo "wamr_aot:      $wamr_output" >> $output_filename

    wamr_output=$(run_command "wamr" "iwasm --heap-size=0 --llvm-jit -f $func_name $wasm_file")
    echo "wamr_jit:      $wamr_output" >> $output_filename

    # =======================================================================================================
    # wasmedge
    # =======================================================================================================
    wasmedge_output=$(run_command "wasmedge" "wasmedge --enable-all --enable-jit run $wasm_file $func_name")
    if [[ "$wamr_output" == *"stack_overflow"* && "$wasmedge_output" == *"timeout"* ]]; then
      wasmedge_output="stack_overflow"
    fi
    echo "wasmedge_jit:  $wasmedge_output" >> $output_filename

    wasmedgei_output=$(run_command "wasmedge" "wasmedge --enable-all --force-interpreter run $wasm_file $func_name")
    if [[ "$wamr_output" == *"stack_overflow"* && "$wasmedgei_output" == *"timeout"* ]]; then
      wasmedgei_output="stack_overflow"
    fi
    echo "wasmedge_interp: $wasmedgei_output" >> $output_filename

    so_file="$wasm_dir/tmpdir/$wasm_filename.so"
    wasmedge_compile_output=$(run_command "wasmedgec" "wasmedge compile $wasm_file $so_file")
    wasmedgec_output=""
    if [[ "$wasmedge_compile_output" == *"Error"* || "$wasmedge_compile_output" == *"error"* ]]; then
      wasmedgec_output="1:<>:"$(postprocess_wasmedge "$wasmedge_compile_output")
    else
      wasmedgec_output=$(run_command "wasmedge" "wasmedge --enable-all run $so_file $func_name")
    fi
    if [[ "$wamr_output" == *"stack_overflow"* && "$wasmedgec_output" == *"timeout"* ]]; then
      wasmedgec_output="stack_overflow"
    fi
    echo "wasmedge_compiled: $wasmedgec_output" >> $output_filename
  fi

  sleep 30
}
export -f delegate

# =========================================================================================================

# Main script logic
func_name=$1
wasm_dir=$2

# rm -rf $wasm_dir/tmpdir 2>/dev/null
mkdir -p $wasm_dir/tmpdir 2>/dev/null

# rm -rf "$wasm_dir/output" 2>/dev/null
mkdir -p "$wasm_dir/output" 2>/dev/null

# =========================================================================================================

find "$wasm_dir" -type f -name "*.wasm" | parallel -j 480 delegate "$wasm_dir" "$func_name" {}

wait
exit 0
