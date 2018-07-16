FROM ambientum/php:7.1
LABEL maintainer="mauri.nunes@fluxoti.com"

USER root

COPY entrypoint.sh /scripts/entrypoint.sh

ENV NR_ENABLED=true

# Installing supervisord
RUN echo " ---> Installing Supervisor" && \
    mkdir -p /etc/supervisord/conf && \
    apk add --update python2 py-pip && \ 
    pip install supervisor && \
    echo_supervisord_conf > /etc/supervisord.conf && \
    echo "[include]" >> /etc/supervisord.conf && \
    echo "files = /etc/supervisord/conf/*.conf" >> /etc/supervisord.conf

RUN chmod +x /scripts/entrypoint.sh

RUN apk add vim busybox-suid

ENV TERM=screen-256color

USER ambientum

WORKDIR /var/www/app

ENTRYPOINT ["/tini", "--", "/scripts/entrypoint.sh"]