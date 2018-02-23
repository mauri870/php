#!/bin/sh

sh /scripts/start.sh

sudo crond
supervisord --configuration /etc/supervisord.conf

if [[ -z "$@" ]]
then
    tail -f /tmp/supervisord.log
else
    exec "$@"
fi
