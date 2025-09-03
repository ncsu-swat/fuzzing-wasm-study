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
(cd $docker_file_path && docker build -t img-wapplique .)
docker run --tmpfs /testcases:rw,size=64g,mode=1777 -d --memory 128g --name container-wapplique-$seed_corpora_name img-wapplique sleep infinity

docker cp $seed_corpora_path container-wapplique-$seed_corpora_name:/wapplique/ingredSeed
docker cp $seed_corpora_path container-wapplique-$seed_corpora_name:/wapplique/SeedPool

# # The following two lines will ensure to always use preprocessed wasmbench for seed_corpora
# docker cp ../../seed_corpora/wasmbench container-wapplique-$seed_corpora_name:/wapplique/ingredSeed # wasmbench is always used as the ingredients seed pool for its size and diversity offering of ingredients
# docker cp Wapplique/ingred/ingred.tar.gz container-wapplique-$seed_corpora_name:/wapplique
# docker exec container-wapplique-$seed_corpora_name bash -c "mkdir -p /wapplique/ingred && tar -xzf ingred.tar.gz -C /wapplique/ingred"

docker exec container-wapplique-$seed_corpora_name bash -c "mkdir -p /testcases"
docker exec container-wapplique-$seed_corpora_name bash -c "timeout $time_limit_s python3 wapplique.py $time_limit"
docker exec container-wapplique-$seed_corpora_name bash -c "cd / && tar -czf testcases.tar.gz /testcases"

mkdir -p $test_cases_path/$seed_corpora_name
docker cp container-wapplique-$seed_corpora_name:/testcases.tar.gz $test_cases_path/$seed_corpora_name/testcases.tar.gz
(cd $test_cases_path/$seed_corpora_name && tar -xzf testcases.tar.gz)

docker exec container-wapplique-$seed_corpora_name bash -c "cd /wapplique && python3 extractor.py mutation.log" 
docker cp container-wapplique-$seed_corpora_name:/wapplique/mutation.log $test_cases_path/$seed_corpora_name
docker cp container-wapplique-$seed_corpora_name:/wapplique/output.json $test_cases_path/$seed_corpora_name
