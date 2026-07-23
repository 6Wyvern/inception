#!/bin/bash

set -e

echo "Starting MariaDB setup..."

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

echo "Starting MariaDB..."
mysqld_safe &
echo "Waiting for MariaDB..."

for i in $(seq 1 30); do
    if mariadb-admin ping >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

if ! mariadb-admin ping >/dev/null 2>&1; then
    echo "MariaDB failed to start."
    exit 1
fi

echo "MariaDB is ready."

echo "Configuring database..."
mariadb -u root -e \
    "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" 2>/dev/null || true
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e \
    "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e \
    "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e \
    "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e \
    "FLUSH PRIVILEGES;"

echo "MariaDB setup complete!"

wait