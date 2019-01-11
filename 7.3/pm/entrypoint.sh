#!/bin/bash

sudo sed -i -e "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php7/php.ini
sudo sed -i -e "s/pm.max_children = 5/pm.max_children = 30/g" /etc/php7/php-fpm.d/www.conf

if [[ -z "$@" ]]
then
    sudo mkdir -p /run/nginx
    sudo nginx
    /home/ambientum/ppm/vendor/bin/ppm \
    start \
    --app-env=${APP_ENV:-dev} \
    --host=0.0.0.0 \
    --port=8081 \
    --bootstrap=$FRAMEWORK \
    --cgi-path=/usr/bin/php-cgi7 \
    --debug=0 \
    /var/www/app
else
    exec "$@"
fi