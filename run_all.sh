#!/bin/bash

if [[ $1 = "deploy" ]]; then
	
	# Deploy Network
	docker network create --subnet=172.77.0.0/16 --driver bridge pubmednet # create custom network

	mkdir -p $PWD/data/postgresql_data
	echo ">> Starting Postgres ..."
	docker run -d --memory="4g" --name postgres -h postgres --ip 172.77.0.11 -p 5433:5433 --network pubmednet \
		-e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=pubmed \
		--user "$(id -u):$(id -g)" -v /etc/passwd:/etc/passwd:ro \
		-v "$PWD/config/postgresql.conf":/etc/postgresql/postgresql.conf \
		-v "$PWD/data/postgresql_data":/var/lib/postgresql/data \
		postgres -c 'config_file=/etc/postgresql/postgresql.conf'

	docker start postgres
	
	echo ">> Starting RabbitMQ ..."
	docker run -dP --memory="4g" --ip 172.77.0.21 -p 5672:5672 -p 15672:15672 --network pubmednet \
		--name rabbitmq \
		-h rabbitmq \
		-v "$PWD/config/rabbitmq.conf":/etc/rabbitmq/rabbitmq.conf \
		-it rabbitmq:3.9-management
		
	docker start rabbitmq
	
	exit
fi
