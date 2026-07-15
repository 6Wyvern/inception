#!/bin/bash

set -e

echo "Starting MariaDB setup..."

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
	mysqld_safe &
	until mariadb-admin ping >/dev/null 2>&1; do
    	sleep 1
	done
	echo "Running SQL..."
	mariadb -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mariadb -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mariadb -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
	mariadb -u root -e "FLUSH PRIVILEGES;"
	echo "Stopping temporary server..."
	mariadb-admin shutdown
fi

echo "Starting MariaDB..."
exec mysqld_safe