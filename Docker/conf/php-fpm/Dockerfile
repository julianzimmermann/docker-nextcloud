FROM php:8.1-fpm-alpine

RUN apk update \
    && apk add zsh \
    && apk add git \
    && apk add vim \
    && apk add zip \
    && apk add libpng-dev \
    && apk add php81-mysqli \
    && apk add php81-curl \
    && apk add php81-gmp \
    && apk add php81-xml \
    && apk add php81-zip \
    && apk add php81-opcache \
    && apk add php81-mbstring \
    && apk add php81-intl \
    && apk add php81-cli \
    && apk add php81-phar \
    && apk add php81-dom \
    && apk add php81-fileinfo \
    && apk add php81-pdo_sqlite \
    && apk add php81-pdo_mysql \
    && apk add php81-session \
    && apk add php81-simplexml \
    && apk add php81-sodium \
    && apk add php81-tokenizer \
    && apk add gettext \
    && apk add icu-dev \
    && apk add libxml2-dev \
    && apk add freetype-dev \
    && apk add libpng-dev \
    && apk add libressl-dev \
    && apk add libwebp-dev \
    && apk add libjpeg-turbo-dev \
    && apk add libxpm-dev \
    && apk add coreutils \
    && apk add libltdl \
    && apk add libzip-dev \
    && apk add libmcrypt-dev \
    && apk add php81-gd \
    && apk add php81-bcmath \
    && apk add busybox-suid \
    && apk add bzip2-dev \
    && apk add icu-dev \
    && apk add openldap-dev \
    && apk add imap-dev \
    && apk add gmp-dev \
    && apk add imagemagick-dev \
    && apk add libmemcached-dev \
    && apk add autoconf \
    && apk add make \
    && apk add gcc \
    && apk add libc-dev \
    && apk add zlib-dev

RUN docker-php-ext-configure gd --enable-gd --with-webp=/usr/include/ --with-freetype --with-jpeg --with-xpm \
    && docker-php-ext-configure intl
RUN docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) pdo \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-enable pdo_mysql \
    && docker-php-ext-enable gd \
    && docker-php-ext-enable bcmath

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN docker-php-ext-install opcache \
    bz2 \
    exif \
    gd \
    gmp \
    imap \
    ldap \
    pcntl \
    && printf "\n" | pecl install imagick \
    && docker-php-ext-enable imagick \
    && printf "\n" | pecl install memcached \
    && docker-php-ext-enable memcached \
    && printf "\n" | pecl install apcu \
    && docker-php-ext-enable apcu

RUN apk del autoconf \
    make \
    gcc

RUN apk add --update nodejs npm
    
RUN npm install -g npm@latest
RUN npm cache clean -f \
    && npm install -g n
#RUN n latest
RUN npm install pm2 -g

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

COPY ./pm2 /var/www/pm2

RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && set -e \
    && export ESC="$" \
    && envsubst < /usr/local/etc/php/conf.d/opcache.ini.template > /usr/local/etc/php/conf.d/opcache.ini \
    && envsubst < /usr/local/etc/php/conf.d/php.ini.template > /usr/local/etc/php/conf.d/php.ini \
    && envsubst < /usr/local/etc/php-fpm.d/www.conf.template > /usr/local/etc/php-fpm.d/www.conf

RUN mkdir -p /var/www/nextcloud/releases/current \
    && chown -R www-data:www-data /var/www/nextcloud/releases/current \
    && chown -R www-data:www-data /var/www/pm2
