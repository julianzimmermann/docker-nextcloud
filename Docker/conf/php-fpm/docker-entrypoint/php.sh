#!/bin/sh
set -e

export ESC="$"

envsubst < /usr/local/etc/php/conf.d/opcache.ini.template > /usr/local/etc/php/conf.d/opcache.ini
envsubst < /usr/local/etc/php/conf.d/opcache.php.template > /usr/local/etc/php/conf.d/php.ini
envsubst < /usr/local/etc/php-fpm.d/www.conf.template > /usr/local/etc/php-fpm.d/www.conf

env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup openrc -u www-data --hp /home/www-data

pm2 start /var/www/pm2/ecosystem.config.js

exec "$@"