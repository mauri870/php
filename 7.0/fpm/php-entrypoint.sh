#!/bin/sh

# Tweaking php.ini with the environment variables
sed -i "s/error_reporting = .*/error_reporting = $PHP_ERROR_REPORTING/" /usr/local/etc/php/php.ini
sed -i "s/display_errors = .*/display_errors = $PHP_DISPLAY_ERRORS/" /usr/local/etc/php/php.ini
sed -i "s/memory_limit = .*/memory_limit = $PHP_MEMORY_LIMIT/" /usr/local/etc/php/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = $PHP_UPLOAD_MAX_FILESIZE/" /usr/local/etc/php/php.ini
sed -i "s/post_max_size = .*/post_max_size = $PHP_POST_MAX_SIZE/" /usr/local/etc/php/php.ini
sed -i "s/;date.timezone.*/date.timezone = $PHP_TIMEZONE/" /usr/local/etc/php/php.ini

# Adding new relic info
if [[ $NEWRELIC_ENABLED == true ]]
then
    echo "php_value[newrelic.enabled] = on" >> /usr/local/etc/php-fpm.d/www.conf
    echo "php_value[newrelic.license] = \"$NEWRELIC_LICENSE\"" >> /usr/local/etc/php-fpm.d/www.conf
    echo "php_value[newrelic.appname] = \"$NEWRELIC_APPNAME\"" >> /usr/local/etc/php-fpm.d/www.conf
fi

php-fpm --nodaemonize --allow-to-run-as-root