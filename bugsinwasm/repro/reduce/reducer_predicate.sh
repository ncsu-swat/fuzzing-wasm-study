#!/bin/bash

# The input wasm_path should be the path to a temporary wasm_path which is ideally copied from the original directory into a reduced directory
temp_wasm_path=$1

reduced_dir="$WASM_DIR/reduced"
mkdir -p $reduced_dir
cp $temp_wasm_path $reduced_dir/temp.wasm

ref_output_path="$WASM_DIR/$FILENAME.txt.txt"
new_output_path="$reduced_dir/output/deduped/temp.txt.txt"

bash /home/ihayet/wasm/scripts/replay/replay_wasm.sh $FUNC_NAME "$reduced_dir"
python3 /home/ihayet/wasm/scripts/eval/dedup_output.py "$reduced_dir/output"

diff_output=$(diff "$ref_output_path" "$new_output_path")
diff_status=$?

echo "++++++++++++++++++++++++++++++++++++++++++"
cat "$ref_output_path"
echo "++++++++++++++++++++++++++++++++++++++++++"
cat "$new_output_path"
echo "++++++++++++++++++++++++++++++++++++++++++"
echo "$diff_output"
echo "++++++++++++++++++++++++++++++++++++++++++"

rm "$reduced_dir/output/temp.txt"
rm "$reduced_dir/output/deduped/temp.txt.txt"
rm "$reduced_dir/temp.wasm"

if [ "$diff_status" -eq 0 ]; then
  exit 0
else
  exit 1
fi