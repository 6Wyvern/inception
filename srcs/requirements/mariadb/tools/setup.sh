#!/bin/bash

set -e

echo "Starting MariaDB setup..."

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    mysqld_safe &
    for i in $(seq 1 30); do
        if mariadb-admin ping >/dev/null 2>&1; then
            break
        fi
        sleep 1
    done
    echo "Running SQL..."
	mariadb -u root -e \
    	"CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mariadb -u root -e \
    	"CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mariadb -u root -e \
    	"GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
	mariadb -u root -e \
    	"ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	mariadb -u root -e \
    	"FLUSH PRIVILEGES;"
    echo "Stopping temporary server..."
    mariadb-admin -u root shutdown
fi

echo "Starting MariaDB..."
exec mysqld_safe