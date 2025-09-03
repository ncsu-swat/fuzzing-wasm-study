check_slurm_job_by_name() {
  local job_name="$1"
  if [ -z "$job_name" ]; then
    echo "Usage: check_slurm_job_by_name <job_name>"
    return 1
  fi

  if [ "$(squeue -u "$USER" --name="$job_name" | tail -n +2 | wc -l)" -gt 0 ]; then
    # echo "Job '$job_name' is still running or pending."
    return 0
  else
    # echo "Job '$job_name' has finished or is not in the queue."
    return 1
  fi
}

# job_names=(
#   wadiff-specbench
#   wasmsmith-noseed
#   wasmaker-bugbench
#   wasmaker-wasmbench
#   wasmaker-transbench
#   wasmaker-specbench
#   wapplique-bugbench
#   wapplique-wasmbench
#   wapplique-transbench
#   wapplique-specbench
# )

# job_names=(
#   wapplique-dummy
# )

job_names=(
  # wapplique-bugbench_ext
  # wasmaker-bugbench_ext
  # wapplique-combobench
  wasmaker-combobench
)

echo -e "\n++ Removing stale containers"
for job in "${job_names[@]}"; do
  container_name="container-${job}"
  if docker ps -a --format '{{.Names}}' | grep -q "^${container_name}$"; then
    docker rm -f $container_name 2&>/dev/null
    printf " + %-32s : Removed.\n" "[$container_name]"
  else
    printf " + %-32s : Does not exist.\n" "[$container_name]"
  fi
done

# ========================================================================================================================

time_stamp=$(date +%s)
time_limit=$1 # in minutes
interval_minutes=1
time_elapsed=0

echo -e "\n++ Starting new "$time_limit"m campaigns."

# (cd wapplique && mkdir -p testcases/$time_stamp 2>/dev/null && srun --job-name=wapplique-bugbench_ext --ntasks=1 --cpus-per-task=30 --cpu-bind=cores --output=../logs/wapplique-bugbench_ext-out.txt --err=../logs/wapplique-bugbench_ext-err.txt bash -c "bash fuzz.sh ../../seed_corpora/bugbench_ext testcases/$time_stamp $time_limit ./Wapplique" &)
# (cd wasmaker && mkdir -p testcases/$time_stamp 2>/dev/null && srun --job-name=wasmaker-bugbench_ext --ntasks=1 --cpus-per-task=30 --cpu-bind=cores --output=../logs/wasmaker-bugbench_ext-out.txt --err=../logs/wasmaker-bugbench_ext-err.txt bash -c "bash fuzz.sh ../../seed_corpora/bugbench_ext testcases/$time_stamp $time_limit ./WASMaker" &)

# (cd wapplique && mkdir -p testcases/$time_stamp 2>/dev/null && srun --job-name=wapplique-combobench --ntasks=1 --cpus-per-task=10 --cpu-bind=cores --output=../logs/wapplique-combobench-out.txt --err=../logs/wapplique-combobench-err.txt bash -c "bash fuzz.sh ../../seed_corpora/combobench testcases/$time_stamp $time_limit ./Wapplique" &)
(cd wasmaker && mkdir -p testcases/$time_stamp 2>/dev/null && srun --job-name=wasmaker-combobench --ntasks=1 --cpus-per-task=30 --cpu-bind=cores --output=../logs/wasmaker-combobench-out.txt --err=../logs/wasmaker-combobench-err.txt bash -c "bash fuzz.sh ../../seed_corpora/combobench testcases/$time_stamp $time_limit ./WASMaker" &)

# (cd wadiff && mkdir -p testcases/$time_stamp 2>/dev/null && srun --job-name=wadiff-specbench --ntasks=1 --cpus-per-task=3 --cpu-bind=cores --output=../logs/wadiff-specbench-out.txt --err=../logs/wadiff-specbench-err.txt bash -c "bash fuzz.sh ../../seed_corpora/specbench testcases/$time_stamp $time_limit ." &)
# (cd wasmsmith && mkdir -p testcases/$time_stamp 2>/dev/null && srun --job-name=wasmsmith-noseed --ntasks=1 --cpus-per-task=3 --cpu-bind=cores --output=../logs/wasmsmith-noseed-out.txt --err=../logs/wasmsmith-noseed-err.txt bash -c "bash fuzz.sh ../../seed_corpora/noseed testcases/$time_stamp $time_limit ." &)

# (cd wasmaker && mkdir testcases/$time_stamp 2>/dev/null && srun --job-name=wasmaker-bugbench --ntasks=1 --cpus-per-task=30 --cpu-bind=cores --output=../logs/wasmaker-bugbench.txt bash -c "bash fuzz.sh ../../seed_corpora/bugbench testcases/$time_stamp $time_limit ./WASMaker" &)
# (cd wasmaker && srun --job-name=wasmaker-wasmbench --ntasks=1 --cpus-per-task=3 --cpu-bind=cores --output=../logs/wasmaker-wasmbench.txt bash -c "bash fuzz.sh ../../seed_corpora/wasmbench testcases/$time_stamp $time_limit ./WASMaker" &)
# (cd wasmaker && srun --job-name=wasmaker-transbench --ntasks=1 --cpus-per-task=3 --cpu-bind=cores --output=../logs/wasmaker-transbench.txt bash -c "bash fuzz.sh ../../seed_corpora/transbench testcases/$time_stamp $time_limit ./WASMaker" &)
# (cd wasmaker && srun --job-name=wasmaker-specbench --ntasks=1 --cpus-per-task=3 --cpu-bind=cores --output=../logs/wasmaker-specbench.txt bash -c "bash fuzz.sh ../../seed_corpora/specbench testcases/$time_stamp $time_limit ./WASMaker" &)
# (cd wapplique && mkdir testcases/$time_stamp 2>/dev/null && srun --job-name=wapplique-bugbench --ntasks=1 --cpus-per-task=3 --cpu-bind=cores --output=../logs/wapplique-bugbench.txt bash -c "bash fuzz.sh ../../seed_corpora/bugbench testcases/$time_stamp $time_limit ./Wapplique" &)
# (cd wapplique && srun --job-name=wapplique-wasmbench --ntasks=1 --cpus-per-task=3 --cpu-bind=cores --output=../logs/wapplique-wasmbench.txt bash -c "bash fuzz.sh ../../seed_corpora/wasmbench testcases/$time_stamp $time_limit ./Wapplique" &)
# (cd wapplique && srun --job-name=wapplique-transbench --ntasks=1 --cpus-per-task=3 --cpu-bind=cores --output=../logs/wapplique-transbench.txt bash -c "bash fuzz.sh ../../seed_corpora/transbench testcases/$time_stamp $time_limit ./Wapplique" &)
# (cd wapplique && srun --job-name=wapplique-specbench --ntasks=1 --cpus-per-task=3 --cpu-bind=cores --output=../logs/wapplique-specbench.txt bash -c "bash fuzz.sh ../../seed_corpora/specbench testcases/$time_stamp $time_limit ./Wapplique" &)

# ======================================== Monitor job completion ========================================
sleep 60

echo -e "\n++ Monitoring Slurm jobs and per-container file counts every $interval_minutes minutes..."
declare -A container_dirs=(
  [wadiff-specbench]="/testcases_tmp/test_std_new_tcs"
  [wasmsmith-noseed]="/testcases"
  [wasmaker-bugbench]="/testcases"
  [wasmaker-wasmbench]="/testcases"
  [wasmaker-transbench]="/testcases"
  [wasmaker-specbench]="/testcases"
  [wapplique-dummy]="/testcases"
  [wapplique-bugbench]="/testcases"
  [wapplique-wasmbench]="/testcases"
  [wapplique-transbench]="/testcases"
  [wapplique-specbench]="/testcases"
)

while true; do
  all_done=true

  echo -e "\n * Time elapsed/total: $time_elapsed/$time_limit minutes"
  time_elapsed=$(( time_elapsed + interval_minutes ))

  for job in "${job_names[@]}"; do
    status="Finished"
    if check_slurm_job_by_name "$job"; then
      all_done=false
      status="Running"
    fi

    container_name="container-${job}"
    container_dir="${container_dirs[$job]:-/testcases}"  # fallback to /testcases

    if docker ps -a --format '{{.Names}}' | grep -q "${container_name}"; then
      count=$(docker exec "$container_name" find "$container_dir" -type f 2>/dev/null | wc -l)
      printf " + %-32s %-12s %-38s %-30s\n" "[$container_name]" "[$status]" "($container_dir)" "Test cases count: $count"

      # echo -e " + [$container_name] [$status] ($container_dir) Test case count: $count"
    else
      printf " + %-32s : Container not found\n" "[$container_name]"
      # echo -e " + [$container_name] Container not found."
    fi
  done

  if $all_done; then
    echo -e "\n++ All Slurm jobs have completed."
    break
  fi

  echo -e " - Sleeping for $interval_minutes minutes before next check ...\n"
  sleep "$((interval_minutes * 60))"
done

# Wait for all background jobs to finish (sanity check)
wait