# Specify seed corpora path (if supported)
seed_corpora_path=$1
seed_corpora_name=$(basename $seed_corpora_path)

# Specify path to store generated test cases
test_cases_path=$2

# Specify fuzzing time (in minutes)
time_limit=$3
time_limit_s=$((time_limit * 60))

# Spin up container
docker_file_path=$4
(cd $docker_file_path && docker build -t img-wasmsmith .)
docker run -d --name container-wasmsmith-$seed_corpora_name img-wasmsmith sleep infinity

echo -e "\nRunning WasmSmith Fuzzer. Please wait.\n"

docker exec container-wasmsmith-$seed_corpora_name bash -c "mkdir /testcases"
docker exec container-wasmsmith-$seed_corpora_name bash -c "(chmod +x ./run.sh && timeout $time_limit_s ./run.sh 1000 $time_limit)"
docker exec container-wasmsmith-$seed_corpora_name bash -c "(cd / && tar -czf testcases.tar.gz /testcases)"

mkdir -p $test_cases_path/$seed_corpora_name
docker cp container-wasmsmith-$seed_corpora_name:/testcases.tar.gz $test_cases_path/$seed_corpora_name/testcases.tar.gz
(cd $test_cases_path/$seed_corpora_name && tar -xzf testcases.tar.gz)
