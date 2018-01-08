FROM ambientum/php:7.1-nginx
LABEL maintainer="mauri.nunes@fluxoti.com"

USER root

RUN apk add nodejs yarn nodejs-npm

USER ambientum

CMD ["/home/ambientum/start.sh"]