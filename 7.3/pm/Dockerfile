FROM ambientum/php:7.3-php-pm
LABEL maintainer="mauri.nunes@fluxoti.com"

ENV TERM=screen-256color

USER root

COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/sites-enabled/
COPY entrypoint.sh /home/ambientum/

RUN apk update && \
    apk add --no-cache nginx nodejs yarn nodejs-npm php7-pdo_sqlite@php php7-sockets@php

USER ambientum

ENTRYPOINT ["/home/ambientum/entrypoint.sh"]