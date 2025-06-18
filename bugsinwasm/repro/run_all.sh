# Check if BUGSINWASM_HOME is set
: "${BUGSINWASM_HOME:?Please set BUGSINWASM_HOME before running this script}"

# Run all the docker containers for each/multiple bugs of each runtime
parentdir="$(dirname "$PWD")"
# runtimes=("wamr" "wasmedge" "wasmtime" "wasmer")
# runtimes=("wamr" "wasmedge" "wasmer")
runtimes=("wasmer")
containers=()

cleanup() {
  echo "Caught CTRL+C, stopping and removing all Docker containers associated with this \"run_all.sh\"."
  for container in "${containers[@]}"; do
    docker stop $container
    docker rm $container
  done
  exit 0
}
trap cleanup SIGINT

# Declare runtime vs. bugnums dictionary
declare -A runtime_bugs_dict
# Diffs
runtime_bugs_dict["wasmtime"]=" 2943 4315 9523 10407 10467 "
#runtime_bugs_dict["wasmer"]=" 5373 3007 2610 4245 4142 3167 4243 "
runtime_bugs_dict["wasmer"]=" 5373 "
runtime_bugs_dict["wamr"]=" 2093 1299 2450 2641 1501 2858 2954 2402 1474 1463 2921 2096 2650 "
runtime_bugs_dict["wasmedge"]=" 3063 3018 2932 2761 2883 2710 2724 2748 "
# Crashes
# ...

# Run all the containers from all the runtimes
for runtime in "${runtimes[@]}"; do
  for bug_path in "$parentdir/$runtime/bugs/"*; do
    bugnum=$(basename $bug_path)
    
    if [[ "${runtime_bugs_dict[$runtime]}" == *" $bugnum "* ]]; then
      echo $runtime, $bugnum

      slurm_session_name="$runtime-$bugnum"
      container_name="container-$slurm_session_name"
      volume_string="\"-v $BUGSINWASM_HOME/repro/testcases:/testcases\""
      img_name="img-$slurm_session_name"

      echo $slurm_session_name, $container_name, $volume_string, $img_name
      srun --job-name="$slurm_session_name" --ntasks=1 --cpus-per-task=10 bash -c "/home/ihayet/util/run_container.sh $slurm_session_name $container_name $volume_string $img_name" &
      containers+=($container_name)
    fi
  done
done

# Wait for all runs to finish
wait
