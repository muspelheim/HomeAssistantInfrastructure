FROM traefik:v1.7.8-alpine

ARG MAIN_DOMAIN
ARG TRAEFIK_MAIN_DOMAIN
ARG TRAEFIK_DEBUG
ARG TRAEFIK_DASHBOARD
ARG TRAEFIK_ACME_EMAIL
ARG RPI_NODE_1
ARG RPI_NODE_2
ARG RPI_NODE_3
ARG AUTH_ESPHOME_USER
ARG AUTH_ESPHOME_PASSWORD

ENV TRAEFIK_RULES_TMPL=/etc/traefik/rules.tmpl \
    TRAEFIK_CONFIG_TMPL=/etc/traefik/traefik.tmpl \
    TRAEFIK_CONFIG=/etc/traefik/traefik.toml \
    TRAEFIK_RULES=/etc/traefik/rules.toml

RUN apk add --no-cache gomplate

COPY config/traefik.tmpl ${TRAEFIK_CONFIG_TMPL}
COPY config/rules.tmpl ${TRAEFIK_RULES_TMPL}
COPY bin/docker-environment.sh /

RUN chmod +x /docker-environment.sh

ENV MAIN_DOMAIN=${MAIN_DOMAIN} \
    TRAEFIK_MAIN_DOMAIN=${TRAEFIK_MAIN_DOMAIN} \
    TRAEFIK_DEBUG=${TRAEFIK_DEBUG} \
    TRAEFIK_DASHBOARD=${TRAEFIK_DASHBOARD} \
    TRAEFIK_ACME_EMAIL=${TRAEFIK_ACME_EMAIL} \
    RPI_NODE_1=${RPI_NODE_1} \
    RPI_NODE_2=${RPI_NODE_2} \
    RPI_NODE_3=${RPI_NODE_3} \
    AUTH_ESPHOME_USER=${AUTH_ESPHOME_USER} \
    AUTH_ESPHOME_PASSWORD=${AUTH_ESPHOME_PASSWORD}

EXPOSE 80 8080 443

ENTRYPOINT ["/docker-environment.sh"]

CMD ["traefik"]

# Metadata
LABEL org.label-schema.vendor="Containous" \
      org.label-schema.url="https://traefik.io" \
      org.label-schema.name="Traefik" \
      org.label-schema.description="A modern reverse-proxy" \
      org.label-schema.version="${TRAEFIK_VERSION}" \
      org.label-schema.docker.schema-version="1.0"