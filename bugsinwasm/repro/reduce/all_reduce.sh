job_names=(
  wadiff-specbench
  wasmsmith-noseed
  wasmaker-bugbench
  wasmaker-wasmbench
  wasmaker-transbench
  wasmaker-specbench
  wapplique-bugbench
  wapplique-wasmbench
  wapplique-transbench
  wapplique-specbench
)

declare -A func_names=(
  [wadiff-specbench]="to_test"
  [wasmsmith-noseed]="main"
  [wasmaker-bugbench]="main"
  [wasmaker-wasmbench]="main"
  [wasmaker-transbench]="main"
  [wasmaker-specbench]="main"
  [wapplique-bugbench]="_start"
  [wapplique-wasmbench]="_start"
  [wapplique-transbench]="_start"
  [wapplique-specbench]="to_test"
)

for job in "${job_names[@]}"; do
  fuzzer_name=$(echo "$job" | cut -d'-' -f1)
  seed_name=$(echo "$job" | cut -d'-' -f2)
  cases_path="/home/ihayet/cases/$fuzzer_name/$seed_name"

  echo "Fuzzer: $fuzzer_name, Seed Corpora: $seed_name"
done