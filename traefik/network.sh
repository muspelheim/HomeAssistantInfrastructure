#!/usr/bin/env bash

#docker network create --driver=overlay traefik-public
docker network create --driver overlay --subnet=10.0.9.0/24 traefik-public
docker network create --driver overlay --subnet=10.0.8.0/24 traefik
docker network create --driver overlay --subnet=10.0.25.0/24 webgateway