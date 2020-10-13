FROM php:7.4-cli

ENV TZ=Asia/Shanghai

COPY ./sources.list.buster /etc/apt/sources.list

RUN apt-get update && apt-get install -y --allow-downgrades \
        sudo \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        git \
        zip \
        zlib1g-dev \
        procps \
	net-tools \
	supervisor \
	curl \
	wget \
	libzip-dev \
    && docker-php-ext-install -j$(nproc) iconv mysqli pdo_mysql pcntl bcmath zip\
    && docker-php-ext-configure gd  --with-jpeg --with-freetype \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install -o -f mcrypt && \
docker-php-ext-enable mcrypt

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

COPY ./php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./supervisor /etc/supervisor/conf.d
RUN mkdir /etc/supervisor/logs
# RUN mkdir -p /usr/share/fonts/chinese/TrueType/simsun.ttc
#COPY ./simsun.ttc /usr/share/fonts/chinese/TrueType/simsun.ttc
RUN apt install wget -y 
RUN wget https://mirrors.aliyun.com/composer/composer.phar -O /usr/bin/composer
#COPY ./composer /usr/bin/composer
RUN chmod +x /usr/bin/composer

# COPY ./wkhtmltopdf /usr/bin
# RUN chmod +x /usr/bin/wkhtmltopdf

# COPY ./simsun.ttc /usr/share/fonts/
# COPY ./simsun.ttf /usr/share/fonts/
COPY ./mysqldump /usr/bin/mysqldump
WORKDIR /var/www/html

