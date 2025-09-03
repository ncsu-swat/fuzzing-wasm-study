#!/bin/bash

# Help message
if [[ $# -lt 2 || "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: $0 <randomness_length> <time_limit_in_minutes>"
  echo ""
  echo "  randomness_length       Number of bytes to read from /dev/urandom for each wasm-tools input"
  echo "  time_limit_in_minutes   Total duration to run the generator loop (in minutes)"
  echo ""
  echo "Example:"
  echo "  $0 1000 1"
  echo "    -> Generates fuzzed wasm files using 1000 bytes of entropy for 1 minute"
  exit 1
fi

randomness_length=$1
time_limit_minutes=$2
time_limit_seconds=$((time_limit_minutes * 60))

start_time=$(date +%s)
idx=0

while true; do
  current_time=$(date +%s)
  elapsed=$((current_time - start_time))

  if (( elapsed > time_limit_seconds )); then
    echo "Reached time limit of $time_limit_minutes minute(s) ($time_limit_seconds seconds)."
    break
  fi

  timestamp=$(date +%s)
  head -c "$randomness_length" /dev/urandom | wasm-tools smith -c config.json -o "/testcases/${idx}_${timestamp}.wasm"
  idx=$((idx + 1))
done
