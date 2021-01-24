FROM jzit/php:7.4-fpm-alpine

RUN apk update \
    && apk add php7-mysqli \
    && apk add gettext \
    && apk add freetype-dev \
    && apk add libpng-dev \
    && apk add libwebp-dev \
    && apk add libxpm-dev \
    && apk add coreutils \
    && apk add libltdl \
    && apk add libmcrypt-dev \
    && apk add php7-gd \
    && apk add php7-bcmath

RUN docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir --enable-gd-native-ttf \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) pdo \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-enable pdo_mysql \
    && docker-php-ext-enable gd \
    && docker-php-ext-enable bcmath

# OPcache defaults
ENV PHP_OPCACHE_ENABLE="1"
ENV PHP_OPCACHE_MEMORY_CONSUMPTION="128"
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES="10000"
ENV PHP_OPCACHE_REVALIDATE_FREQUENCY="1"
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"

# PHP-FPM defaults
ENV PHP_FPM_PM="dynamic"
ENV PHP_FPM_MAX_CHILDREN="5"
ENV PHP_FPM_START_SERVERS="2"
ENV PHP_FPM_MIN_SPARE_SERVERS="1"
ENV PHP_FPM_MAX_SPARE_SERVERS="2"
ENV PHP_FPM_MAX_REQUESTS="1000"


ENV PHP_INI_UPLOAD_SIZE=1024M
ENV PHP_INI_SMTP=localhost
ENV PHP_INI_SMTP_PORT=25
ENV PHP_INI_MEMORY_LIMIT=1024M
ENV PHP_INI_MAX_INPUT_TIME=60
ENV PHP_INI_MAX_EXECUTION_TIME=30

# Add the opcache configuration
COPY ./opcache.ini.template "$PHP_INI_DIR/conf.d/opcache.ini.template"

# Add php.ini
COPY ./php.ini.template "$PHP_INI_DIR/conf.d/php.ini.template"

# Copy the PHP-FPM configuration file
COPY ./www.conf.template /usr/local/etc/php-fpm.d/www.conf.template

COPY ./docker-entrypoint/php.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && set -e \
    && export ESC="$" \
    && envsubst < /usr/local/etc/php/conf.d/opcache.ini.template > /usr/local/etc/php/conf.d/opcache.ini \
    && envsubst < /usr/local/etc/php/conf.d/php.ini.template > /usr/local/etc/php/conf.d/php.ini \
    && envsubst < /usr/local/etc/php-fpm.d/www.conf.template > /usr/local/etc/php-fpm.d/www.conf

RUN mkdir -p /var/www/nextcloud/releases/current \
    && chown -R www-data:www-data /var/www/nextcloud/releases/current