# Check if BUGSINWASM_HOME is set
: "${BUGSINWASM_HOME:?Please set BUGSINWASM_HOME before running this script}"

# Build all the docker containers for each/multiple bugs of each runtime
parentdir="$(dirname "$PWD")"
# runtimes=("wamr" "wasmedge" "wasmtime" "wasmer")
runtimes=("wasmer")

# Build base images
for runtime in "${runtimes[@]}"; do
  slurm_session_name="$runtime"
  # build_ctxs="\"reprodir=/home/ihayet/bugsinwasm/repro\""
  build_args="\"BUGSINWASM_HOME=$BUGSINWASM_HOME\""
  img_name="img-$runtime"
  ctx_path=$parentdir/$runtime/bugs

  echo -e "\nBuilding base image: $img_name"
  echo -e $slurm_session_name, $build_args, $img_name, $ctx_path, "\n"
  srun --job-name="$slurm_session_name" --ntasks=1 --cpus-per-task=100 bash -c "/home/ihayet/util/build_container.sh $slurm_session_name $build_args $img_name $ctx_path" &
done

# Wait for all base image builds to finish
wait

# Declare runtime vs. bugnums dictionary
declare -A runtime_crashes_dict
declare -A runtime_diffs_dict

# Crashes
runtime_crashes_dict["wasmtime"]=" 212 "
# runtime_crashes_dict["wasmer"]="  "
runtime_crashes_dict["wasmer"]=" 2743 "
runtime_crashes_dict["wamr"]=" 2754 "
runtime_crashes_dict["wasmedge"]=" 2159 "

# Diffs
runtime_diffs_dict["wasmtime"]=" 2943 4315 9523 10407 10467 "
# runtime_diffs_dict["wasmer"]=" 5373 3007 2610 4245 4142 3167 4243 "
runtime_diffs_dict["wasmer"]=" 5373 "
runtime_diffs_dict["wamr"]=" 2093 1299 2450 2641 1501 2858 2954 2402 1474 1463 2921 2096 2650 "
runtime_diffs_dict["wasmedge"]=" 3063 3018 2932 2761 2883 2710 2724 2748 "

# ========================================================================================================================

# Build crash images
for runtime in "${runtimes[@]}"; do
  for bug_path in "$parentdir/$runtime/bugs/crashes"*; do
    bugnum=$(basename $bug_path)
    
    if [[ "${runtime_crashes_dict[$runtime]}" == *" $bugnum "* ]]; then
      echo $runtime, $bugnum

      # Diffs
      python3 gen_dockerfile.py crashes.json $runtime $bugnum

      slurm_session_name="$runtime-$bugnum"
      # build_ctxs="\"reprodir=/home/ihayet/bugsinwasm/repro\""
      build_args="\"BUGSINWASM_HOME=$BUGSINWASM_HOME\""
      img_name="img-$slurm_session_name"
      ctx_path=$bug_path

      mkdir $bug_path/repro 2>/dev/null
      cp -f $BUGSINWASM_HOME/repro/dedup/trace_callback.py $bug_path/repro
      cp -f $BUGSINWASM_HOME/repro/dedup/trace.sh $bug_path/repro
      cp -f $BUGSINWASM_HOME/repro/crash_analyzer.sh $bug_path/repro
      cp -f $BUGSINWASM_HOME/repro/crashes.json $bug_path/repro

      echo -e "\nBuilding crash image: $img_name"
      echo -e $slurm_session_name, $build_args, $img_name, $ctx_path, "\n"
      srun --job-name="$slurm_session_name" --ntasks=1 --cpus-per-task=20 bash -c "/home/ihayet/util/build_container.sh $slurm_session_name $build_args $img_name $ctx_path" &
    fi
  done
done

# ========================================================================================================================

# Build diff images
for runtime in "${runtimes[@]}"; do
  for bug_path in "$parentdir/$runtime/bugs/diffs"*; do
    bugnum=$(basename $bug_path)
    
    if [[ "${runtime_diffs_dict[$runtime]}" == *" $bugnum "* ]]; then
      echo $runtime, $bugnum

      # Diffs
      python3 gen_dockerfile.py diffs.json $runtime $bugnum

      slurm_session_name="$runtime-$bugnum"
      # build_ctxs="\"reprodir=/home/ihayet/bugsinwasm/repro\""
      build_args="\"BUGSINWASM_HOME=$BUGSINWASM_HOME\""
      img_name="img-$slurm_session_name"
      ctx_path=$bug_path

      mkdir $bug_path/repro 2>/dev/null
      cp -f $BUGSINWASM_HOME/repro/dedup/diff_trace.py $bug_path/repro
      cp -f $BUGSINWASM_HOME/repro/diff_analyzer.sh $bug_path/repro
      cp -f $BUGSINWASM_HOME/repro/diffs.json $bug_path/repro

      echo -e "\nBuilding diff image: $img_name"
      echo -e $slurm_session_name, $build_args, $img_name, $ctx_path, "\n"
      srun --job-name="$slurm_session_name" --ntasks=1 --cpus-per-task=20 bash -c "/home/ihayet/util/build_container.sh $slurm_session_name $build_args $img_name $ctx_path" &
    fi
  done
done

# ========================================================================================================================

# Wait for all builds to finish
wait

# Prune dangling images to save space
docker image prune -f
