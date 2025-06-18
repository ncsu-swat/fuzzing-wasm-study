import json
import sys
import os

config_path = sys.argv[1]
runtime = sys.argv[2]
bugnum = sys.argv[3]

with open(config_path, 'r') as config_file:
  config = json.load(config_file)
  bugconfig = config[runtime][bugnum]

  docker_config = bugconfig["docker"]
  docker = "\n\n".join([
    "\n".join(docker_config["preamble"]),
    "\n".join(docker_config["setup_runtime"]),
    "\n".join(docker_config["build_runtime"]),
    "\n".join(docker_config["setup_bug"]),
    "\n".join(docker_config["setup_workspace"]),
    "\n".join(docker_config["init_cmd"])
  ])
  docker = docker.replace("<runtime>", runtime)
  docker = docker.replace("<bugnum>", bugnum)
  docker = docker.replace("<test_commit_sha>", bugconfig["test_commit"])
  docker = docker.replace("<oracle_commit_sha>", bugconfig["oracle_commit"])
  docker = docker.replace("<bug_path_host>", "./")
  docker = docker.replace("<bug_path_container>", "/bugs/{}".format(bugnum))

  with open(os.path.join(os.path.expandvars(bugconfig["path"]), "Dockerfile"), 'w+') as docker_file:
    docker_file.write(docker)