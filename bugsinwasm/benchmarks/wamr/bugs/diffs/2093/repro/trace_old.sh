#!/bin/bash

# trace_combined.sh: Run LLDB with a custom Python trace_callback for output-triggered backtraces.
#
# Usage:
#   ./trace_combined.sh <program_path> "<program_args>" "<target_output>" "<path_filter>" <trace_output_file> <disable_sigsegv>
#
# Arguments:
#   program_path       - Path to the target binary
#   program_args       - Quoted string of arguments to pass to the target program
#   target_output      - Substring to match in write() output to trigger a backtrace
#   path_filter        - Substring to match in file paths to restrict backtrace locations
#   trace_output_file  - File to store backtrace results
#   disable_sigsegv    - "yes" to prevent LLDB from catching SIGSEGV (used for incorrect-output debugging)
#                        "no" to allow LLDB to catch SIGSEGV (used for segfault debugging)

# ----------------------------------------------
# Check argument count
# ----------------------------------------------
if [ "$#" -ne 6 ]; then
    echo "Usage: $0 <program_path> \"<program_args>\" \"<target_output>\" \"<path_filter>\" <trace_output_file> <disable_sigsegv>"
    echo
    echo "  <program_path>       Path to the target binary"
    echo "  <program_args>       Quoted string of arguments to pass to the target program"
    echo "  <target_output>      Substring to match in write() output to trigger a backtrace"
    echo "  <path_filter>        Substring to match in file paths to restrict backtrace locations"
    echo "  <trace_output_file>  File to store backtrace results"
    echo "  <disable_sigsegv>    'yes' to prevent LLDB from catching SIGSEGV (ignore signal)"
    echo "                       'no' to allow LLDB to catch SIGSEGV (default behavior)"
    exit 1
fi

# ----------------------------------------------
# Assign arguments
# ----------------------------------------------
program_path=$1
program_args=$2
target_output=$3
path_filter=$4
trace_output_file=$5
disable_sigsegv=$6

# ----------------------------------------------
# Validate SIGSEGV flag
# ----------------------------------------------
if [[ "$disable_sigsegv" != "yes" && "$disable_sigsegv" != "no" ]]; then
    echo "Error: <disable_sigsegv> must be either 'yes' or 'no'"
    exit 1
fi

# ----------------------------------------------
# Construct LLDB SIGSEGV handling command
# ----------------------------------------------
if [ "$disable_sigsegv" == "yes" ]; then
    sigsegv_cmd="process handle SIGSEGV -n true -p true -s false"
else
    sigsegv_cmd="process handle SIGSEGV -n false -p true -s true"
fi

# ---------------------------------------------------------------------
# Remove any existing trace output file with the same name
# ---------------------------------------------------------------------
rm $trace_output_file 2&>/dev/null

# ----------------------------------------------
# Run LLDB with inline commands
# ----------------------------------------------
if [ "$disable_sigsegv" == "yes" ]; then
  lldb --batch \
      --one-line "script import trace_callback; trace_callback.target_output = '$target_output'" \
      --one-line "script trace_callback.path_filter = '$path_filter'" \
      --one-line "script trace_callback.trace_output_file = '$trace_output_file'" \
      --one-line "process launch --stop-at-entry" \
      --one-line "breakpoint set -n write --condition '(int)\$rdi == 1 || (int)\$rdi == 2'" \
      --one-line "breakpoint command add -s python -F trace_callback.write_callback" \
      --one-line "process handle SIGSEGV -n false -p true -s false" \
      --one-line "process continue" \
      --one-line "quit" \
      -- "$program_path" $program_args
else
  # lldb --batch \
  #     --one-line "script import trace_callback; trace_callback.target_output = '$target_output'" \
  #     --one-line "script trace_callback.path_filter = '$path_filter'" \
  #     --one-line "script trace_callback.trace_output_file = '$trace_output_file'" \
  #     --one-line "process launch --stop-at-entry" \
  #     --one-line "process handle SIGSEGV -n true -p true -s true" \
  #     --one-line "script trace_callback.monitor_segfaults(lldb.debugger)" \
  #     --one-line "quit" \
  #     -- "$program_path" $program_args
  lldb --batch \
      --one-line "script import trace_callback; trace_callback.target_output = '$target_output'" \
      --one-line "script trace_callback.path_filter = '$path_filter'" \
      --one-line "script trace_callback.trace_output_file = '$trace_output_file'" \
      --one-line "process launch --stop-at-entry" \
      --one-line "process handle SIGSEGV -n true -p true -s true" \
      --one-line "command script add -f trace_callback.crash_hook crash_hook" \
      --one-line "target stop-hook add -o crash_hook" \
      --one-line "process continue" \
      --one-line "quit" \
      -- "$program_path" $program_args
fi
