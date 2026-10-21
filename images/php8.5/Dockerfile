# The official image instead of phpswoole/swoole:php8.5, which still shipped PHP 8.5.11 hours
# after the PHP2Shell fix (CVE-2026-109618 / 109619). Swoole and the extensions that image
# bundled (redis, sockets, pdo_mysql) are installed below.
FROM php:8.5-cli

# Refuse to build on PHP without the PHP2Shell fix.
RUN php -r 'exit(version_compare(PHP_VERSION, "8.5.12", ">=") ? 0 : 1);'

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
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        sockets \
        zip \
    # pecl.php.net kept dropping downloads from CI on 2026-10-21, so the PECL extensions are
    # retried rather than failing the whole image on one bad download.
    && for attempt in 1 2 3 4 5; do install-php-extensions redis swoole && break; sleep 30; done \
    && php -m | grep -qx redis \
    && php -m | grep -qx swoole

WORKDIR /var/www/html
