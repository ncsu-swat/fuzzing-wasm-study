# Specify seed corpora path (if supported)
seed_corpora_path=$1
seed_corpora_name=$(basename $seed_corpora_path)

# Specify path to store generated test cases
test_cases_path=$2

# Specify fuzzing time (in minutes)
time_limit=$3

# Spin up container
docker_file_path=$4
(cd $docker_file_path && docker build -t img-wadiff .)
docker run -d --name container-wadiff-$seed_corpora_name img-wadiff sleep infinity

docker exec container-wadiff-$seed_corpora_name bash -c "mkdir /testcases"
docker exec container-wadiff-$seed_corpora_name bash -c "mkdir /testcases_tmp"
docker exec container-wadiff-$seed_corpora_name bash -c "rm -rf /testcases_tmp/*"
docker exec container-wadiff-$seed_corpora_name bash -c "(cd /home/wadiff/spec2test && python3 -m pip install -r requirements.txt)"

echo -e "\nRunning WaDiff Fuzzer. Please wait.\n"

start_time=$(date +%s)
# docker exec container-wadiff-$seed_corpora_name bash -c "(cd /home/wadiff/spec2test && python3 generate_tcs_main.py generation_configs/v19.json $start_time $time_limit)"
docker exec container-wadiff-$seed_corpora_name bash -c "(cd /home/wadiff/mutator && python3 run_dir_std_testing_main.py /home/wadiff/spec2test/generated_tcs/v19/tcs /testcases_tmp $start_time $time_limit)"
docker exec container-wadiff-$seed_corpora_name bash -c "(find /testcases_tmp/test_std_new_tcs /home/wadiff/spec2test/generated_tcs/v19/tcs -type f -name "*.wasm" -exec cp {} /testcases/ \;)"
docker exec container-wadiff-$seed_corpora_name bash -c "(cd / && tar -czf testcases.tar.gz testcases)"

mkdir -p $test_cases_path/$seed_corpora_name
docker cp container-wadiff-$seed_corpora_name:/testcases.tar.gz $test_cases_path/$seed_corpora_name/testcases.tar.gz
(cd $test_cases_path/$seed_corpora_name && tar -xzf testcases.tar.gz)