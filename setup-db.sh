#!/bin/bash
# This scripts sets up a database with the specified sql dump from ./data.
if [ "$#" -ne 1 ]; then
    	echo "Illegal number of parameters"
	echo "usage: setup-db.sh <path to db dump in data folder>"
else
	echo "Stopping old container in case it is running"
	docker container stop $(docker container ls -a  --format "{{.Image}} {{.Names}}" | grep "hyperledger/explorer-db" | awk '{print $2}')
	echo "Removing old container"
	docker container rm $(docker container ls -a  --format "{{.Image}} {{.Names}}" | grep "hyperledger/explorer-db" | awk '{print $2}')
	echo "Deleting old db volume"
	docker volume rm $(docker volume ls | grep "pgdata"  | awk '{print $2}')
	echo "Starting new container"
	docker-compose up -d
	STATUS=`docker ps --format "{{.Image}} {{.Status}}" | grep "hyperledger/explorer-db" | awk '{print $NF}' | awk '{$1=$1};1'`
	while [ `echo $STATUS | grep "healthy" | wc -l` -ne 1 ]
	do
		echo "Container status is $STATUS"
		STATUS=`docker ps --format "{{.Image}} {{.Status}}" | grep "hyperledger/explorer-db" | awk '{print $NF}' | awk '{$1=$1};1'`
		echo "Waiting 5s for container to become healthy"
		sleep 5s
	done
	echo "Container is healthy"
	echo "Restoring specified database: $1"
	docker exec -t $(docker container ls -a  --format "{{.Image}} {{.Names}}" | grep "hyperledger/explorer-db" | awk '{print $2}') ./restore.sh $1
fi
