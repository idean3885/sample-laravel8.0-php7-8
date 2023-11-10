FROM alpine:3.18

RUN apk update upgrade && \
    apk add git && \
    apk add ca-certificates && \
    apk add curl

# Installing bash
#RUN apk add bash
#RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

## Installing PHP
ARG PHP_VERSION=php82
RUN apk add --no-cache ${PHP_VERSION} \
    ${PHP_VERSION}-common \
    ${PHP_VERSION}-fpm \
    ${PHP_VERSION}-pdo \
    ${PHP_VERSION}-opcache \
    ${PHP_VERSION}-zip \
    ${PHP_VERSION}-phar \
    ${PHP_VERSION}-iconv \
    ${PHP_VERSION}-cli \
    ${PHP_VERSION}-curl \
    ${PHP_VERSION}-openssl \
    ${PHP_VERSION}-mbstring \
    ${PHP_VERSION}-tokenizer \
    ${PHP_VERSION}-fileinfo \
    ${PHP_VERSION}-json \
    ${PHP_VERSION}-xml \
    ${PHP_VERSION}-xmlwriter \
    ${PHP_VERSION}-simplexml \
    ${PHP_VERSION}-dom \
    ${PHP_VERSION}-pdo_mysql \
    ${PHP_VERSION}-pdo_sqlite \
    ${PHP_VERSION}-tokenizer \
    ${PHP_VERSION}-pecl-redis
RUN ln -s /usr/bin/${PHP_VERSION} /usr/bin/php

# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm -rf composer-setup.php

WORKDIR /app
COPY . .

RUN composer install

ENTRYPOINT php artisan serve --host=0

