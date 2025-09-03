#!/bin/bash

wasm_path=$1
export FUNC_NAME=$2

export WASM_DIR=$(dirname "$wasm_path")
filename_with_ext="${wasm_path##*/}"
export FILENAME="${filename_with_ext%.*}"

shrunken_wasm_path="$WASM_DIR/shrunken_$FILENAME.wasm"
shrunken_wat_path="$WASM_DIR/shrunken_$FILENAME.wat"

export TMPDIR="/tmp"

RUST_LOG=info timeout 1440m wasm-tools shrink -a 100000 ./reducer_predicate.sh "$wasm_path" -o "$shrunken_wasm_path"
if [ -f "$shrunken_wasm_path" ]; then
  wasm-tools print "$shrunken_wasm_path" -o "$shrunken_wat_path"
fi

rm -rf "$WASM_DIR/reduced" 2>/dev/null