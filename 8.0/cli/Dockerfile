FROM alpine:3.12

LABEL maintainer="mauri.nunes@fluxoti.com" 

# TODO: Remove unnecessary envs
ENV OPCACHE_MODE="normal" \
    TERM=screen-256color \
    PHP_MEMORY_LIMIT=256M \
    XDEBUG_ENABLED=false \
    TERM=xterm-256color \
    COLORTERM=truecolor \
    COMPOSER_PROCESS_TIMEOUT=1200

COPY etc /etc
COPY scripts /scripts
COPY bashrc /home/bashrc

RUN apk add --update \
    wget \
    curl \
    openssh \
    bash \
    fontconfig \
    libxrender \
    libxext \
    imagemagick \
    nano \
    vim \
    git \
    unzip \
    wget \
    sudo \
    autoconf \
    linux-headers \
    g++ \
    libpng-dev \
    gcc \
    make \
    musl-dev \
    pcre2-dev \
    # PHP
    php8 \
    php8-pear \
    php8-dev \
    php8-pecl-apcu \
    php8-bcmath \
    php8-bz2 \
    php8-calendar \
    php8-curl \
    php8-ctype \
    php8-exif \
    php8-fpm \
    php8-fileinfo \
    php8-gd \
    php8-gmp \
    php8-iconv \
    php8-imap \
    php8-intl \
    php8-json \
    php8-mbstring \
    php8-mysqli \
    php8-mysqlnd \
    php8-pdo_mysql \
    php8-mongodb \
    php8-opcache \
    php8-pdo_pgsql \
    php8-pgsql \
    php8-posix \
    php8-redis \
    php8-soap \
    php8-sodium \
    php8-sqlite3 \
    php8-pdo_sqlite \
    php8-pecl-xdebug \
    php8-xml \
    php8-xmlreader \
    php8-openssl \
    php8-phar \
    php8-xsl \
    php8-zip \
    php8-zlib \
    php8-pcntl \
    php8-gettext \
    php8-cgi \
    php8-tokenizer \
    php8-xmlwriter \
    php8-simplexml \
    php8-phpdbg && \
    sudo ln -s /usr/bin/php8 /usr/bin/php && \
    sudo ln -s /usr/bin/php-cgi8 /usr/bin/php-cgi && \
    sudo ln -s /usr/sbin/php-fpm8 /usr/sbin/php-fpm && \
    sudo ln -s /usr/bin/pear8 /usr/bin/pear && \
    sudo ln -s /usr/bin/pecl8 /usr/bin/pecl && \
    # Custom PHP extensions
    pecl channel-update pecl.php.net && \
    pear config-set php_ini /etc/php8/php.ini && \
    pecl install timezonedb && \
    # Composer installation
    # FIXME: Install composer 2 here.
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --1 && \
    rm -rf /tmp/* && \
    # Ambientum user
    adduser -D -u 1000 ambientum && \
    echo "ambientum  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /var/www/app && \
    chown -R ambientum:ambientum /var/www && \
    chown -R ambientum:ambientum /home/ambientum && \
    chown -R ambientum:ambientum /scripts && \
    chown -R ambientum:ambientum /home/bashrc && \
    # PHP settings tunning
    sed -i "/user = .*/c\user = ambientum" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/^group = .*/c\group = ambientum" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/listen.owner = .*/c\listen.owner = ambientum" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/listen.group = .*/c\listen.group = ambientum" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/listen = .*/c\listen = [::]:9000" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/;access.log = .*/c\access.log = /proc/self/fd/2" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/;clear_env = .*/c\clear_env = no" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/pid = .*/c\;pid = /run/php/php8.1-fpm.pid" /etc/php8/php-fpm.conf && \
    sed -i "/;daemonize = .*/c\daemonize = yes" /etc/php8/php-fpm.conf && \
    sed -i "/error_log = .*/c\error_log = /proc/self/fd/2" /etc/php8/php-fpm.conf && \
    sed -i "/;rlimit_files = .*/c\rlimit_files = 8192" /etc/php8/php-fpm.conf && \
    sed -i "/;rlimit_core = .*/c\rlimit_core = unlimited" /etc/php8/php-fpm.conf && \
    sed -i "/post_max_size = .*/c\post_max_size = 1000M" /etc/php8/php.ini && \
    sed -i "/upload_max_filesize = .*/c\upload_max_filesize = 1000M" /etc/php8/php.ini && \
    sed -i "/zend_extension=xdebug/c\;zend_extension=xdebug" /etc/php8/conf.d/50_xdebug.ini && \
    chmod +x /scripts/*.sh && \
    rm -rf /tmp/* && \
    # Tiny init
    wget -O /tini https://github.com/krallin/tini/releases/download/v0.19.0/tini-static && \
    chmod +x /tini

# Define the running user
USER ambientum

# Application directory
WORKDIR "/var/www/app"

# Environment variables
ENV PATH=/scripts:/home/ambientum/.composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENTRYPOINT ["/tini", "--", "/scripts/entrypoint.sh"]

# As non daemon and single base image, it may be used as cli container
CMD ["/bin/bash"]
