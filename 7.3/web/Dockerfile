FROM ambientum/php:7.3-nginx
LABEL maintainer="mauri.nunes@fluxoti.com"

ENV TERM=screen-256color

USER root

COPY nginx.conf /etc/nginx/
COPY entrypoint.sh /home/ambientum/

RUN apk update && \
    apk add -u nodejs yarn nodejs-npm php-sockets

USER ambientum

ENTRYPOINT ["/home/ambientum/entrypoint.sh"]
