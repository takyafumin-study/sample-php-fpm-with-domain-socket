FROM composer:2.6.6 as composer
FROM php:8.3.2-fpm-alpine3.19 AS builder

COPY --from=composer /usr/bin/composer /usr/local/bin/
COPY --from=mlocati/php-extension-installer:2.2 /usr/bin/install-php-extensions /usr/local/bin/

RUN set -eux \
 && apk update \
 && apk --no-cache add \
    git=2.43.0-r0 \
    unzip=6.0-r14 \
    libzip-dev=1.10.1-r0 \
 && install-php-extensions bcmath exif opcache zip

WORKDIR /var/www/src

FROM builder as dev

RUN set -eux \
 && apk update \
 && apk --no-cache add \
    autoconf=2.71-r2 \
    gcc=13.2.1_git20231014-r0 \
    g++=13.2.1_git20231014-r0 \
    make=4.4.1-r2 \
  && install-php-extensions xdebug

FROM builder as prod

COPY ./src /var/www/src
RUN composer install
