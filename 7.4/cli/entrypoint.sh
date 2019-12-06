#!/bin/sh

sed -i -e "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php7/php.ini
sed -i -e "s/pm.max_children = 5/pm.max_children = 30/g" /etc/php7/php-fpm.d/www.conf

sh /scripts/start.sh

sudo crond
supervisord --configuration /etc/supervisord.conf

if [[ -z "$@" ]]
then
    tail -f /tmp/supervisord.log
else
    exec "$@"
fi
