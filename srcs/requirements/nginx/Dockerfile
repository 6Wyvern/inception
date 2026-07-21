FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
        nginx \
        openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 443

ENTRYPOINT ["/setup.sh"]