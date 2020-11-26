FROM fluxoti/php:8.0-cli
LABEL maintainer="mauri.nunes@fluxoti.com" 

USER root

RUN apk add --update \
	nginx \
	nodejs \
	yarn \
	nodejs-npm && \
	rm -rf /tmp/* /var/tmp/* /usr/share/doc/* && \
	# Fixing permissions
	mkdir /var/tmp/nginx && \
	mkdir /var/run/nginx && \
	chown -R ambientum:ambientum /var/tmp/nginx && \
	chown -R ambientum:ambientum /var/run/nginx && \
	chown -R ambientum:ambientum /var/log/nginx && \
	chown -R ambientum:ambientum /var/lib/nginx && \
	chown -R ambientum:ambientum /home/ambientum

COPY nginx.conf /etc/nginx/
COPY entrypoint.sh /home/ambientum/

USER ambientum

ENTRYPOINT ["/home/ambientum/entrypoint.sh"]
