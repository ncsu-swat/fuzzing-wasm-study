import subprocess
import sys

def cmd(commandline):
    # print(commandline)
    status, output = subprocess.getstatusoutput(commandline)
    # print(output)
    return status, output

if __name__ == "__main__":
    seed_dir = "./SeedPool"
    ingredSeed = "./ingredSeed/"
    ingred_dir = "./ingred"
    case_dir = "/testcases"
    time_limit = sys.argv[1] # in minutes

    cmd("python3 extract.py {} {} > extract.log".format(ingredSeed, ingred_dir))
    print("Finish Contructing Ingredient Pool, Start Mutating...")
    cmd("python3 test.py normal {} {} {} {} > test.log".format(seed_dir, ingred_dir, case_dir, time_limit))
    print("Finished Generating New Test Case.")
