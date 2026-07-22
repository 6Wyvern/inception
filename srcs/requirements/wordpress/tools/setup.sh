#!/bin/bash

set -e

echo "Starting WordPress..."

MYSQL_PASSWORD=$(cat /run/secrets/db_password)

mkdir -p /run/php

if ! wp core is-installed --path=/var/www/html --allow-root >/dev/null 2>&1; then
    echo "Downloading WordPress..."
    mkdir -p /var/www/html

    wp core download \
        --path=/var/www/html \
        --allow-root

    until mariadb \
        -h mariadb \
        -u"$MYSQL_USER" \
        -p"$MYSQL_PASSWORD" \
        -e "SELECT 1;" >/dev/null 2>&1
    do
        echo "Waiting for MariaDB..."
        sleep 2
    done

    echo "Creating wp-config.php..."

    wp config create \
        --path=/var/www/html \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb" \
        --skip-check \
        --allow-root

    echo "Installing WordPress..."

    wp core install \
        --path=/var/www/html \
        --url="$DOMAIN_NAME" \
        --title="Inception" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    echo "Creating WordPress user..."

    wp user create \
        "$WP_USER" \
        "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --allow-root \
        --path=/var/www/html
fi

echo "Starting PHP-FPM..."

chown -R www-data:www-data /var/www/html

exec php-fpm7.4 -F