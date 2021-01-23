#!/bin/sh
set -e

export ESC="$"

envsubst < /usr/local/etc/php/conf.d/opcache.ini.template > /usr/local/etc/php/conf.d/opcache.ini
envsubst < /usr/local/etc/php/conf.d/opcache.php.template > /usr/local/etc/php/conf.d/php.ini
envsubst < /usr/local/etc/php-fpm.d/www.conf.template > /usr/local/etc/php-fpm.d/www.conf

exec "$@"