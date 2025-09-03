import os
import sys
import json
import pymongo
import time
from multiprocessing import Process, Queue, cpu_count

from BREWasm import *
from WASMaker.fuzzer.AST import *
from WASMaker.parser.opnames import *
from WASMaker.settings import *

my_client = pymongo.MongoClient(MONGODB_URI)
runtime_fuzz_db = my_client[MONGODB_CLIENT]

seed_corpora_path = sys.argv[1]


def clear_mongodb():
    db = my_client[MONGODB_CLIENT]
    for collection in db.list_collection_names():
        db[collection].drop()


def init_mongodb():
    for collection_name in opnames:
        if collection_name:
            runtime_fuzz_db[collection_name].insert_one({})
            runtime_fuzz_db[collection_name].delete_many({})


def annotate_with_seed_name(obj, seed_name):
    if isinstance(obj, dict):
        obj.setdefault("origin_seed_name", seed_name)
        for v in obj.values():
            annotate_with_seed_name(v, seed_name)
    elif isinstance(obj, list):
        for v in obj:
            annotate_with_seed_name(v, seed_name)


def worker(file_path, q):
    try:
        print(f"Processing file: {file_path}")
        seed_name = os.path.basename(file_path)
        wasm_binary = BREWasm(file_path)
        internal_func_num = len(wasm_binary.module.code_sec)

        for i in range(internal_func_num):
            function_AST = FunctionAST(wasm_binary, i)
            AST_list = function_AST.init_AST(
                function_AST.binary.module.code_sec[i].expr
            )

            json_string = ast_to_json(AST_list)
            AST_nodes_json = json.loads(json_string)

            annotate_with_seed_name(AST_nodes_json, seed_name)
            store_mongodb(AST_nodes_json)

        q.put(f"Processed {file_path}")
    except Exception as ex:
        q.put(f"Failed {file_path}: {ex}")


def process_with_timeout(file_path, timeout=60):
    q = Queue()
    p = Process(target=worker, args=(file_path, q))
    p.start()
    p.join(timeout)

    if p.is_alive():
        p.terminate()
        p.join()
        return f"Timeout {file_path}"

    if not q.empty():
        return q.get()
    return f"Unknown failure {file_path}"


if __name__ == "__main__":
    clear_mongodb()
    init_mongodb()

    all_files = [
        os.path.join(root, file)
        for root, _, files in os.walk(seed_corpora_path)
        for file in files
    ]

    # Sequential loop, each file handled in its own process with timeout
    for f in all_files:
        result = process_with_timeout(f, 60)
        print(result)