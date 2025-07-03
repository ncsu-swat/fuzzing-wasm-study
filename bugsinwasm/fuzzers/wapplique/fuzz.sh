# Specify seed corpora path (if supported)
seed_corpora_path=$1
seed_corpora_name=$(basename $seed_corpora_path)

# Specify path to store generated test cases
test_cases_path=$2

# Specify fuzzing time (in minutes)
time_limit=$3

# Spin up container
docker_file_path=$4
(cd $docker_file_path && docker build -t img-wapplique .)
docker run -d --name container-wapplique-$seed_corpora_name img-wapplique sleep infinity
docker cp $seed_corpora_path/ingredSeed container-wapplique-$seed_corpora_name:/wapplique/ingredSeed
docker cp $seed_corpora_path/SeedPool container-wapplique-$seed_corpora_name:/wapplique/SeedPool

docker exec container-wapplique-$seed_corpora_name bash -c "mkdir /testcases"
docker exec container-wapplique-$seed_corpora_name bash -c "python3 wapplique.py $time_limit"
docker exec container-wapplique-$seed_corpora_name bash -c "cd / && tar -czf testcases.tar.gz /testcases"

mkdir -p $test_cases_path/$seed_corpora_name
docker cp container-wapplique-$seed_corpora_name:/testcases.tar.gz $test_cases_path/$seed_corpora_name/testcases.tar.gz
(cd $test_cases_path/$seed_corpora_name && tar -xzf testcases.tar.gz)
