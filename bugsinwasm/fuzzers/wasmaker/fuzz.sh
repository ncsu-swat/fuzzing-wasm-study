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
(cd $docker_file_path && docker build -t img-wasmaker .)
docker run -d --memory 32g --name container-wasmaker-$seed_corpora_name img-wasmaker sleep infinity
docker cp $seed_corpora_path container-wasmaker-$seed_corpora_name:/seed_corpora
docker exec container-wasmaker-$seed_corpora_name bash -c "(cd /home/ubuntu/BREWasm &&  python3 -m pip install -e .)"
docker exec container-wasmaker-$seed_corpora_name bash -c "(cd / && bash start.sh)"

preprocess_start_time=$(date +%s)
if [ -e "./preprocessed-dbs/$seed_corpora_name/runtime-fuzz" ]; then
  docker exec container-wasmaker-$seed_corpora_name bash -c "mkdir -p /saved-db/runtime-fuzz"
  docker cp ./preprocessed-dbs/$seed_corpora_name/runtime-fuzz container-wasmaker-$seed_corpora_name:/saved-db/
  docker exec container-wasmaker-$seed_corpora_name bash -c "(mongorestore /saved-db)"
else
  mkdir -p ./preprocessed-dbs/$seed_corpora_name
  docker exec container-wasmaker-$seed_corpora_name bash -c "(cd /home/ubuntu/WASMaker && timeout $time_limit_s python3 corpus_preprocess.py /seed_corpora)"
  docker exec container-wasmaker-$seed_corpora_name bash -c "(mongodump --db=runtime-fuzz --out=/saved-db)"
  docker cp container-wasmaker-$seed_corpora_name:/saved-db/runtime-fuzz/ ./preprocessed-dbs/$seed_corpora_name
fi
preprocess_end_time=$(date +%s)
preprocess_time_s=$(( preprocess_end_time - preprocess_start_time ))
remaining_time_s=$(( time_limit_s - preprocess_time_s ))

if [ "$remaining_time_s" -ge 0 ]; then
  docker exec container-wasmaker-$seed_corpora_name bash -c "mkdir /testcases"
  docker exec container-wasmaker-$seed_corpora_name bash -c "(cd /home/ubuntu/WASMaker && timeout $remaining_time_s python3 fuzz.py $time_limit)"
  docker exec container-wasmaker-$seed_corpora_name bash -c "(cd / && tar -czf testcases.tar.gz /testcases)"

  mkdir -p $test_cases_path/$seed_corpora_name
  docker cp container-wasmaker-$seed_corpora_name:/testcases.tar.gz $test_cases_path/$seed_corpora_name/testcases.tar.gz
  (cd $test_cases_path/$seed_corpora_name && tar -xzf testcases.tar.gz)

  docker cp container-wasmaker-$seed_corpora_name:/home/ubuntu/WASMaker/provenance.jsonl $test_cases_path/$seed_corpora_path
  docker cp container-wasmaker-$seed_corpora_name:/home/ubuntu/WASMaker/provenance.json $test_cases_path/$seed_corpora_path
else
  echo -e "\n !!! RAN OUT OF TIME (while preprocessing?) !!!\n"
fi
