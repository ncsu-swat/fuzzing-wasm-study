#!/bin/bash

# trace_combined.sh: Run LLDB with a custom Python trace_callback for analyzing output differences
#
# Usage:
#   ./trace_diff.sh <program_path> "<program_args>" <trace_output_file>
#
# Arguments:
#   program_path       - Path to the target binary
#   program_args       - Quoted string of arguments to pass to the target program
#   trace_output_file  - File to store backtrace results

# ----------------------------------------------
# Check argument count
# ----------------------------------------------
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <program_path> \"<program_args>\" <trace_output_file>"
    echo
    echo "  <program_path>       Path to the target binary"
    echo "  <program_args>       Quoted string of arguments to pass to the target program"
    echo "  <trace_output_file>  File to store backtrace results"
    exit 1
fi

# ----------------------------------------------
# Assign arguments
# ----------------------------------------------
program_path=$1
program_args=$2
trace_output_file=$3

# ---------------------------------------------------------------------
# Remove any existing trace output file with the same name
# ---------------------------------------------------------------------
rm $trace_output_file 2&>/dev/null

# ----------------------------------------------
# Run LLDB with inline commands
# ----------------------------------------------
lldb --batch \
    --one-line "script import trace_callback" \
    --one-line "script trace_callback.trace_output_file = '$trace_output_file'" \
    --one-line "breakpoint set --name main" \
    --one-line "breakpoint command add -s python -F trace_callback.trace_breakpoint" \
    --one-line "run" \
    -- "$program_path" $program_args
