#!/bin/bash

set -e

echo "Starting MariaDB setup..."

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
	mysqld_safe &
	until mariadb-admin ping >/dev/null 2>&1; do
    	sleep 1
	done
	mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
	mysql -e "FLUSH PRIVILEGES;"
fi

exec mysqld_safe