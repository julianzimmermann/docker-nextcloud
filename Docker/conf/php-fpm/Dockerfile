FROM php:8.3-fpm

RUN rm -rf /etc/apt/sources.list.d/debian.sources

COPY sources.list /etc/apt/sources.list

RUN apt update \ 
    && apt install -y zsh \
    && apt install -y git \
    && apt install -y vim \
    && apt install -y zip \
    && apt install -y libpng-dev \
    && apt install -y gettext \
    && apt install -y icu-devtools \
    && apt install -y libxml2-dev \
    && apt install -y libfreetype6-dev \
    && apt install -y libssl-dev \
    && apt install -y libwebp-dev \
    && apt install -y libjpeg62-turbo-dev \
    && apt install -y libxpm-dev \
    && apt install -y coreutils \
    && apt install -y libltdl-dev \
    && apt install -y libzip-dev \
    && apt install -y libmcrypt-dev \
    && apt install -y busybox \
    && apt install -y bzip2 \
    && apt install -y libgmp-dev \
    && apt install -y imagemagick \
    && apt install -y libmagickwand-dev \
    && apt install -y libmemcached-dev \
    && apt install -v libpq-dev \
    && apt install -v libicu-dev \
    && apt install -v libxml2-dev \
    && apt install -v libcurl4-openssl-dev \
    && apt install -v pkg-config \
    && apt install -v libpq-dev \
    && apt install -y autoconf \
    && apt install -y make \
    && apt install -y gcc \
    && apt install -y libc-dev \
    && apt install -y zlib1g-dev \
    && apt install -y libbz2-dev

RUN docker-php-ext-configure gd --enable-gd --prefix=/usr --with-freetype --with-jpeg --with-webp --with-xpm \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure intl

RUN docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) pdo \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) sysvsem \
    && docker-php-ext-enable pdo_mysql \
    && docker-php-ext-enable gd \
    && docker-php-ext-enable bcmath

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN docker-php-ext-install opcache \
bz2 \
exif \
gmp \
pcntl \
&& printf "\n" | pecl install memcached \
&& docker-php-ext-enable memcached \
&& printf "\n" | pecl install apcu \
&& docker-php-ext-enable apcu \
&& printf "\n" | pecl install redis \
&& docker-php-ext-enable redis

RUN git clone https://github.com/Imagick/imagick.git --depth 1 /tmp/imagick && \
    cd /tmp/imagick && \
    git fetch origin master && \
    git switch master && \
    cd /tmp/imagick && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    docker-php-ext-enable imagick

RUN apt remove -y autoconf \
make \
gcc

# OPcache defaults
ENV PHP_OPCACHE_ENABLE="1"
ENV PHP_OPCACHE_MEMORY_CONSUMPTION="128"
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES="10000"
ENV PHP_OPCACHE_REVALIDATE_FREQUENCY="1"
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"
ENV PHP_OPCACHE_INTERNED_STRINGS_BUFFER="15"

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

