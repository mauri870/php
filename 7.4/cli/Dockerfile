# TODO: Updgrade this image to 7.4
FROM ambientum/php:7.3
LABEL maintainer="mauri.nunes@fluxoti.com"

USER root

COPY entrypoint.sh /scripts/entrypoint.sh

# TODO: Remove this after update image
RUN sudo sed -i 's/php-7.3/php-7.4/g' /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add vim busybox-suid php-sockets php7-pear php7-dev autoconf g++ && \
    # Install supervisord
    echo " ---> Installing Supervisor" && \
    mkdir -p /etc/supervisord/conf && \
    apk add python2 py-pip && \ 
    pip install supervisor && \
    echo_supervisord_conf > /etc/supervisord.conf && \
    echo "[include]" >> /etc/supervisord.conf && \
    echo "files = /etc/supervisord/conf/*.conf" >> /etc/supervisord.conf

# Install custom extensions
RUN pecl channel-update pecl.php.net && \
    pear config-set php_ini /etc/php7/php.ini && \
    pecl install timezonedb hrtime


ENV TERM=screen-256color

USER ambientum

WORKDIR /var/www/app

ENTRYPOINT ["/tini", "--", "/scripts/entrypoint.sh"]
