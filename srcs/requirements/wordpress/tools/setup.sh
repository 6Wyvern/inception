#!/bin/bash

set -e

echo "Starting WordPress..."

mkdir -p /run/php

exec php-fpm7.4 -F