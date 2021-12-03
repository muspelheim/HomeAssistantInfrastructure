#!/bin/sh

PASSWDFILE=/etc/mosquitto/passwd

if [ -f $PASSWDFILE ]; then
    echo "converting password file"
    mosquitto_passwd -U $PASSWDFILE
fi

exec "$@"
