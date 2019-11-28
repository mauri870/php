FROM ambientum/php:7.3-nginx
LABEL maintainer="mauri.nunes@fluxoti.com"

ENV TERM=screen-256color

USER root

COPY nginx.conf /etc/nginx/
COPY entrypoint.sh /home/ambientum/

RUN apk update && apk upgrade && \
    apk add nodejs yarn nodejs-npm php7-pear php7-dev autoconf g++

# Install custom extensions
RUN pecl upgrade redis && \
    pecl channel-update pecl.php.net && \
    pear config-set php_ini /etc/php7/php.ini && \
    pecl install timezonedb hrtime

USER ambientum

ENTRYPOINT ["/home/ambientum/entrypoint.sh"]
