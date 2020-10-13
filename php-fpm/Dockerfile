FROM php:7.4-fpm

ENV TZ=Asia/Shanghai

COPY ./sources.list.buster /etc/apt/sources.list

RUN apt-get update && apt-get install -y --allow-downgrades \
	sudo \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
	libxext-dev \
	libfontconfig1-dev \
	libxrender-dev \
        git \
        zip \
        zlib1g-dev \
        libzip-dev \
	wget \
    && docker-php-ext-install -j$(nproc) iconv mysqli pdo_mysql pcntl bcmath zip\
    && docker-php-ext-configure gd  --with-jpeg --with-freetype \
    && docker-php-ext-install -j$(nproc) gd 

RUN pecl install -o -f mcrypt && \
docker-php-ext-enable mcrypt

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

COPY ./wkhtmltopdf /usr/local/bin

COPY ./simsun.ttc /usr/share/fonts/

RUN chmod +x /usr/local/bin/wkhtmltopdf

COPY ./php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini
