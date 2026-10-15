#!/bin/bash
set -e

echo "Starting WordPress..."

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

mkdir -p /run/php /var/www/html

if [ ! -f /var/www/html/wp-includes/version.php ]; then
    echo "Downloading WordPress..."
    wp core download \
        --path=/var/www/html \
        --allow-root
fi

until mariadb \
    -h mariadb \
    -u"$MYSQL_USER" \
    -p"$MYSQL_PASSWORD" \
    -e "SELECT 1;" >/dev/null 2>&1
do
    echo "Waiting for MariaDB..."
    sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --path=/var/www/html \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost=mariadb \
        --skip-check \
        --allow-root
fi

if ! wp core is-installed --path=/var/www/html --allow-root; then
    echo "Installing WordPress..."
    wp core install \
        --path=/var/www/html \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --path=/var/www/html \
        --allow-root
fi

wp option update home "https://${DOMAIN_NAME}" \
    --path=/var/www/html --allow-root

wp option update siteurl "https://${DOMAIN_NAME}" \
    --path=/var/www/html --allow-root

echo "WordPress setup complete!"
chown -R www-data:www-data /var/www/html

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F