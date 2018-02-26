FROM ambientum/php:7.2
LABEL maintainer="mauri.nunes@fluxoti.com"

USER root

COPY entrypoint.sh /scripts/entrypoint.sh

# Installing supervisord
RUN echo " ---> Installing Supervisor" && \
    mkdir -p /etc/supervisord/conf && \
    apk add --update python2 py-pip && \ 
    pip install supervisor && \
    echo_supervisord_conf > /etc/supervisord.conf && \
    echo "[include]" >> /etc/supervisord.conf && \
    echo "files = /etc/supervisord/conf/*.conf" >> /etc/supervisord.conf

RUN sed -i -e "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php7/php.ini

RUN chmod +x /scripts/entrypoint.sh

RUN apk add vim busybox-suid

ENV TERM=screen-256color

USER ambientum

WORKDIR /var/www/app

ENTRYPOINT ["/tini", "--", "/scripts/entrypoint.sh"]