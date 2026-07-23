#!/bin/bash

set -e

echo "Starting NGINX..."

mkdir -p /etc/nginx/ssl

if [ ! -f /etc/nginx/ssl/inception.crt ] || \
   [ ! -f /etc/nginx/ssl/inception.key ]; then

    echo "Generating SSL certificate..."

    openssl req -x509 \
        -nodes \
        -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=ES/ST=Catalonia/L=Barcelona/O=42/OU=Student/CN=manualva.42.fr"
fi

echo "NGINX Setup complete!"
echo "Starting NGINX..."

exec nginx -g "daemon off;"