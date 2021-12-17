#!/bin/bash

docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker network rm pubmednet
docker rmi pubmedknowledgegraph_worker:latest pubmedknowledgegraph_manager:latest
