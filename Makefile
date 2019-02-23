export PROJECT_DIR:=$(PWD)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo ""
	@echo "HA available targets:"
	@echo ""
	@grep -E '^.PHONY:.*##.*' $(MAKEFILE_LIST) | cut -c9- | sort | awk 'BEGIN {FS = " ## "}; {printf "%-30s %s\n", $$1, $$2}'

.PHONY: deploy-monitoring ## Deploy monitoring stack to docker swarm
deploy-monitoring:
	cd monitoring && . ../bin/pidarota && docker stack deploy -c docker-compose.yml monitoring

.PHONY: deploy-traefik ## Deploy traefik stack to docker swarm
deploy-traefik:
	cd traefik && . ../bin/pidarota && docker stack deploy -c docker-compose.yml traefik

.PHONY: deploy-portainer ## Deploy portainer stack to docker swarm
deploy-portainer:
	. ./bin/pidarota && docker stack deploy -c portainer-agent-stack.yml portainer

.PHONY: remove-monitoring ## Deploy monitoring stack to docker swarm
remove-monitoring:
	docker stack rm monitoring

.PHONY: remove-traefik ## Deploy traefik stack to docker swarm
remove-traefik:
	docker stack rm traefik

.PHONY: remove-portainer ## Deploy portainer stack to docker swarm
remove-portainer:
	docker stack rm portainer

.PHONY: init-networks ## Init overlay docker networks
init-networks:
	docker network create --driver overlay --subnet=10.0.9.0/24 traefik-public \
	&& docker network create --driver overlay --subnet=10.0.8.0/24 traefik
