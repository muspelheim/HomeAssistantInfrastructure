#!/usr/bin/env bash

#Todo: makefile

docker stack deploy -c portainer-agent-stack.yml portainer

cd traefik
docker stack deploy -c docker-compose.yml traefik
cd ..

cd monitoring
docker stack deploy -c docker-compose.yml monitoring
cd ..