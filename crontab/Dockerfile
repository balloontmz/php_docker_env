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

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

COPY ./php.ini /usr/local/etc/php/conf.d/php.ini

RUN apt-get install cron -y
RUN apt-get install rsyslog -y

COPY ./crontab /tmp

RUN cat /tmp/crontab >> /etc/crontab

RUN sed -i '/session    required     pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/cron

#CMD ["sh", "-c", "service rsyslog start ; tail -f /dev/null"]
CMD ["sh", "-c", "service rsyslog restart; service cron restart ; tail -f /dev/null"]
