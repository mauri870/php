#!/bin/bash

sudo ln -s /etc/nginx/sites/rr.conf /etc/nginx/sites/enabled.conf

_term() {
  echo "Shutting down nginx"
  kill -SIGQUIT "$nginxpid"
  echo "Shutting down RoadRunner"
  kill -SIGQUIT "$rrpid"
}

# Starts NGINX!
if [[ -z "$@" ]]
then
    trap _term SIGTERM

    rr serve -v -d 2>&1 &
    rrpid=$!

    nginx 2>&1 &
    nginxpid=$!
    wait "$rrpid"
    wait "$nginxpid"
else
    exec "$@"
fi
