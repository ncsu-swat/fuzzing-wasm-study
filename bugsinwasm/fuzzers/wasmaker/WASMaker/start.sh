#!/bin/bash

# start SSH service
sudo service ssh start

# reset MongoDB service if already running
sudo pkill mongod 2>/dev/null
sudo rm -rf /data/db 2>/dev/null

# start MongoDB service
sudo mkdir -p /data/db
sudo chown -R `id -u` /data/db
sudo mongod --fork --logpath /var/log/mongod.log

# wait for MongoDB
sleep 10