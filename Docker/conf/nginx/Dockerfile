FROM jzit/nginx:alpine-latest

RUN apk update \
    && apk add gettext

# Copy the NGINX configuration template file
COPY ./conf.d/config.template /etc/nginx/conf.d/default.template

# Copy the docker entrypoint file
COPY ./docker-entrypoint/nginx.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]