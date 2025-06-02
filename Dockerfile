FROM dunglas/frankenphp:latest AS base
#1.6-php8.3-bookworm
WORKDIR /app

# Development stage
FROM base AS dev
# copy required in prod && here no need to copy code inject from docker-compose 
COPY php/php.dev.ini /usr/local/etc/php/conf.d/custom.ini


# Production stage
FROM base AS prd
COPY . .
COPY php/php.prod.ini /usr/local/etc/php/conf.d/custom.ini
RUN chmod -R 755 /app/public
RUN apt-get update && \
    apt-get install -y unzip git curl && \
    curl -sS https://getcomposer.org/installer | php && \
    php composer.phar install
RUN php artisan config:clear
RUN php artisan route:clear
RUN php artisan config:cache
RUN php artisan route:cache

CMD ["frankenphp", "run"]
