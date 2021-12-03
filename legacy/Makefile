export PROJECT_DIR:=$(PWD)

args = `arg="$(filter-out $(firstword $(MAKECMDGOALS)),$(MAKECMDGOALS))" && echo $${arg:-${1}}`

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

.PHONY: deploy-influx ## Deploy influx stack to docker swarm
deploy-influx:
	cd influx && . ../bin/pidarota && docker stack deploy -c docker-compose.yml influx

.PHONY: remove-monitoring ## Remove monitoring stack to docker swarm
remove-monitoring:
	docker stack rm monitoring

.PHONY: remove-traefik ## Remove traefik stack to docker swarm
remove-traefik:
	docker stack rm traefik

.PHONY: remove-portainer ## Remove portainer stack to docker swarm
remove-portainer:
	docker stack rm portainer

.PHONY: remove-influx ## Remove stack to docker swarm
remove-influx:
	docker stack rm influx

.PHONY: init-networks ## Init overlay docker networks
init-networks:
	docker network create --driver overlay --subnet=10.0.9.0/24 traefik-public \
	&& docker network create --driver overlay --subnet=10.0.8.0/24 traefik

.PHONY: ansible-run ## Run Ansible role (example: make ansible-run pi.yml)
ansible-run:
	docker-compose pull ansible_cli && ./ansible/scripts/bootstrap-node $(call args)

.PHONY: ansible-build ## Build Ansible image
ansible-build:
	./ansible/scripts/init-system

.PHONY: mqtt-setup ## Build-Setup MQTT Brocker image
mqtt-setup:
	cd mqtt && . ../bin/pidarota && ../bin/passwd-gen ${PROJECT_DIR}/mqtt/config/.passwd \
	&& docker stack rm mqtt \
	&& docker-compose build && docker-compose push \
	&& docker stack deploy -c docker-compose.yml mqtt

.PHONY: traefik-setup ## Build-Setup traefik image
traefik-setup:
	cd traefik && . ../bin/pidarota \
	&& docker stack rm traefik \
	&& docker-compose build && docker-compose push \
	&& docker stack deploy -c docker-compose.yml traefik