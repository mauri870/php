FROM fluxoti/php:7.0-fpm
MAINTAINER FluxoTI <lucas.gois@fluxoti.com>

COPY . /build

# Removing the standard config from the original image
RUN echo " ---> Preparing environment" && \
rm /usr/local/etc/php-fpm.d/www.conf && \
rm /php-entrypoint.sh && cp /build/php-entrypoint.sh /php-entrypoint.sh && \
chmod +x /php-entrypoint.sh && \

# Installing Caddy
echo " ---> Installing Caddy" && \
curl https://getcaddy.com | bash && \

# Copying our config
cp /build/www.conf /usr/local/etc/php-fpm.d/www.conf && \
cp /build/Caddyfile /root

# CleanUP
RUN echo " ---> Cleaning up" && \
rm -rf /build

VOLUME /var/www/html

EXPOSE 8080

ENTRYPOINT ["/sbin/tini", "--", "/php-entrypoint.sh"]
