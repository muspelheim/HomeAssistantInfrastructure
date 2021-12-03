#!/bin/sh

set -e

gomplate -f ${TRAEFIK_CONFIG_TMPL} -o ${TRAEFIK_CONFIG}
gomplate -f ${TRAEFIK_RULES_TMPL} -o ${TRAEFIK_RULES}

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- traefik "$@"
fi

# if our command is a valid Traefik subcommand, let's invoke it through Traefik instead
# (this allows for "docker run traefik version", etc)
if traefik "$1" --help 2>&1 >/dev/null | grep "help requested" > /dev/null 2>&1; then
    set -- traefik "$@"
fi

exec "$@"

