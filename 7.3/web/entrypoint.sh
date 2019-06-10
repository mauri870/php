#!/bin/bash

sudo sed -i -e "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php7/php.ini
sudo sed -i -e "s/pm.max_children = 5/pm.max_children = 30/g" /etc/php7/php-fpm.d/www.conf

echo "Aliasing $FRAMEWORK"
sudo ln -s /etc/nginx/sites/$FRAMEWORK.conf /etc/nginx/sites/enabled.conf

_term() {
  echo "Shutting down nginx"
  kill -SIGQUIT "$nginxpid"
  echo "Shutting down php-fpm"
  kill -SIGQUIT "$fpmpid"
}

# Starts NGINX!
if [[ -z "$@" ]]
then
    trap _term SIGTERM

    # Starts FPM
    php-fpm7 -y /etc/php7/php-fpm.conf -F -O 2>&1 &
    fpmpid=$!

    nginx &
    nginxpid=$!
    wait "$fpmpid"
    wait "$nginxpid"
else
    exec "$@"
fi
