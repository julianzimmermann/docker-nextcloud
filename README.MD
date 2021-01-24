# Docker Setup for Nexcloud

Provides a docker environment for nextcloud. It creates two docker volumes, one for the nextcloud installation and one for the user data. After the build, you have to jump with `docker exec -it nextcloud_php zsh` on the php container and the owner for `/var/www/nextcloud/data` to www-data (`chown -R www-data:www-data /var/www/nextcloud/data`) and install nextcloud manually to `/var/www/nextcloud/releases/current`

## Nextcloud config
add to the nextcloud config array (config/config.php) `'trusted_proxies' => '172.18.0.3/16'`. To get the correct proxy ip write `docker inspect reverse_proxy` on the docker host system. At the end you will find the networks configuration with
```
"Networks": {
    "web": {
        ...
        "IPAddress": "172.18.0.3",
        "IPPrefixLen": 16,
        ...
    }
}
```

## Requirements

Needs a running traefik reverse proxy! You can use my setup for this: https://github.com/julianzimmermann/docker-traefik

## Build

### With make

`make docker-build`

### With docker-compose
`docker-compose up --build -d`

## Testing
- Check `php-fpm` config: `docker-compose exec nextcloud_php php-fpm -tt`
- Check `php.ini` settings: `docker-compose exec nextcloud_php php-fpm -i`
