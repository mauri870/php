FROM ambientum/php:7.4-nginx
LABEL maintainer="mauri.nunes@fluxoti.com"

ENV TERM=screen-256color

USER root

COPY nginx.conf /etc/nginx/
COPY entrypoint.sh /home/ambientum/

RUN apk update && apk upgrade && \
    apk add nodejs linux-headers yarn nodejs-npm php7-pear php7-dev autoconf g++ libpng-dev gcc make musl-dev pcre2-dev

# Install custom extensions
RUN pecl channel-update pecl.php.net && \
    pear config-set php_ini /etc/php7/php.ini && \
    pecl install timezonedb hrtime grpc protobuf

USER ambientum

ENTRYPOINT ["/home/ambientum/entrypoint.sh"]
