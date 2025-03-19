#!/bin/sh
set -e

export ESC="$"

envsubst < /usr/local/etc/php/conf.d/opcache.ini.template > /usr/local/etc/php/conf.d/opcache.ini
envsubst < /usr/local/etc/php/conf.d/opcache.php.template > /usr/local/etc/php/conf.d/php.ini

pm2 start /var/www/pm2/ecosystem.config.js

exec "$@"
