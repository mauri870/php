FROM ambientum/php:7.1-nginx
LABEL maintainer="mauri.nunes@fluxoti.com"

ENV TERM=screen-256color

USER root

COPY nginx.conf /etc/nginx/nginx.conf

RUN apk add nodejs yarn nodejs-npm vim

# only needed until codecasts/ambientum#65 is merged
RUN apk add php7-pdo_sqlite@php

USER ambientum

CMD ["/home/ambientum/start.sh"]