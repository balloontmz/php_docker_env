FROM php:7.2-cli

ENV TZ=Asia/Shanghai


RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        git \
        zip \
	    wkhtmltopdf \
	    sudo \
	    curl \
    && docker-php-ext-install -j$(nproc) iconv mysqli pdo_mysql pcntl bcmath zip\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
#RUN apt-get install gcc g++ make
RUN apt-get install -y nodejs
RUN npm install apidoc -g

RUN pecl install -o -f swoole \
    && docker-php-ext-enable swoole

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

COPY ./php.ini /usr/local/etc/php/conf.d/php.ini

#RUN apt install wget -y 
#RUN wget https://getcomposer.org/download/1.6.5/composer.phar -O /usr/bin/composer
COPY ./composer /usr/bin/composer
RUN chmod +x /usr/bin/composer
RUN composer config -g repo.packagist composer https://packagist.laravel-china.org
RUN composer global require laravel/installer

COPY ./wkhtmltopdf /usr/bin
RUN chmod +x /usr/bin/wkhtmltopdf

WORKDIR /var/www/html


