FROM php:7.2-fpm

ENV TZ=Asia/Shanghai

#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
#    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
#    echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
#    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
#    echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list

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
    && docker-php-ext-install -j$(nproc) iconv mysqli pdo_mysql pcntl bcmath zip\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

#COPY ../extensions/swoole-src-4.3.3.zip /
#RUN unzip /swoole-src-4.3.3.zip swoole && \
#    cd swoole && phpize && ./configure && make && sudo make install
RUN pecl install -o -f swoole \
    && docker-php-ext-enable swoole

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

COPY ./wkhtmltopdf /usr/bin
RUN chmod +x /usr/bin/wkhtmltopdf

COPY ./simsun.ttc /usr/share/fonts/

COPY ./php.ini /usr/local/etc/php/conf.d/php.ini

