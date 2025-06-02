#!/bin/sh

if [ -n "$APP_KEY" ] && [ -n "$APP_ENV" ]; then
  echo "Warming up Laravel cache..."
  php artisan config:clear
  php artisan route:clear
  php artisan config:cache
  php artisan route:cache
else
  echo "APP_KEY or APP_ENV not set, skipping artisan cache..."
fi

exec "$@"