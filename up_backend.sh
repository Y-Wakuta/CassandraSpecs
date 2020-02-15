#!/bin/bash

set -e

docker-compose down
docker-compose build --no-cache
docker-compose up -d
echo "start sleep"
sleep 40 
echo "create db and table"
docker exec cassandra_spec /bin/bash create_keyspace.sh
