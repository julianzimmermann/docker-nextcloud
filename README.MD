# Docker Setup for Nexcloud

## Build

`docker-compose up --build -d`

## Testing
- Check `php-fpm` config: `docker-compose exec php php-fpm -tt`
- Check `php.ini` settings: `docker-compose exec php php-fpm -i`
