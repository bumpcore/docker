# Shared runtime/build base for Bumpcore Laravel + Octane apps.
# Pin SWOOLE_TAG when you need a specific PHP/Swoole pair.
ARG SWOOLE_TAG=php8.5
FROM phpswoole/swoole:${SWOOLE_TAG}

ENV DEBIAN_FRONTEND=noninteractive \
    COMPOSER_ALLOW_SUPERUSER=1

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY --from=oven/bun:1 /usr/local/bin/bun /usr/local/bin/bun

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        unzip \
        supervisor \
    && rm -rf /var/lib/apt/lists/* \
    && install-php-extensions \
        bcmath \
        exif \
        gd \
        intl \
        pcntl \
        pdo_pgsql \
        pgsql \
        zip

WORKDIR /var/www/html
