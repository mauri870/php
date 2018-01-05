#!/bin/sh

sh /scripts/start.sh

sudo crond
supervisord --nodaemon --configuration /etc/supervisord.conf
