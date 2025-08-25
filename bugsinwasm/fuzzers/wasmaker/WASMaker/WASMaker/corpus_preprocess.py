import os
import sys

import json # Added by ME

import pymongo
from BREWasm import *

from WASMaker.fuzzer.AST import *
from WASMaker.parser.opnames import *
from WASMaker.settings import *

from multiprocessing import Process
import time

my_client = pymongo.MongoClient(MONGODB_URI)
runtime_fuzz_db = my_client[MONGODB_CLIENT]

seed_corpora_path = sys.argv[1]

def clear_mongodb():
  db = my_client[MONGODB_CLIENT]

  collections = db.list_collection_names()

  for collection in collections:
    db[collection].drop()


def init_mongodb():
  collection_names = opnames

  for collection_name in collection_names:
    if collection_name:
      runtime_fuzz_db[collection_name].insert_one({})
      runtime_fuzz_db[collection_name].delete_many({})


def annotate_with_seed_name(obj, seed_name): #Added by ME

  if isinstance(obj, dict):
    obj.setdefault("origin_seed_name", seed_name)
    for v in obj.values():
      annotate_with_seed_name(v, seed_name)
  elif isinstance(obj, list):
    for v in obj:
      annotate_with_seed_name(v, seed_name)

clear_mongodb()
init_mongodb()

try:
  for root, dirs, files in os.walk(seed_corpora_path):
    for file in files:
      try:
        print(f"Processing {file}")
        
        file_path = os.path.join(root, file)
        seed_name = os.path.basename(file_path) # Added by ME

        wasm_binary = BREWasm(file_path)

        internal_func_num = len(wasm_binary.module.code_sec)

        for i in range(internal_func_num):
          function_AST = FunctionAST(wasm_binary, i)
          AST_list = function_AST.init_AST(function_AST.binary.module.code_sec[i].expr)

          json_string = ast_to_json(AST_list)
          AST_nodes_json = json.loads(json_string)

          annotate_with_seed_name(AST_nodes_json, seed_name) #Added by ME


          store_mongodb(AST_nodes_json)
          # print("function :" + str(i))
      except Exception as ex:
        print(ex, "continuing")
except Exception as e:
  print(e)
