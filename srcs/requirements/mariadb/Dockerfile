FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
        mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/mariadb.conf

COPY tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 3306

ENTRYPOINT ["/setup.sh"]