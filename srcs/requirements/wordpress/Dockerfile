FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
        php-fpm \
        php-mysql \
        php-cli \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 9000

ENTRYPOINT ["/setup.sh"]