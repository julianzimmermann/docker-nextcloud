FROM jzit/nginx:alpine-latest

# Copy the NGINX configuration template file
COPY ./conf.d/config.template /etc/nginx/conf.d/default.template

# Copy the docker entrypoint file
COPY ./docker-entrypoint/nginx.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]