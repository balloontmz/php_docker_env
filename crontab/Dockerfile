FROM php:7.4-cli

ENV TZ=Asia/Shanghai

COPY ./sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y -f --allow-downgrades \
	sudo \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        git \
        zip \
        zlib1g-dev \
        supervisor \
	net-tools \
        procps \
	net-tools \
	supervisor \
	curl \
	wget \
	libzip-dev
 
RUN  docker-php-ext-install -j$(nproc) iconv mysqli pdo_mysql zip pcntl bcmath

RUN  docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install -j$(nproc) gd

RUN pecl install -o -f mcrypt && \
docker-php-ext-enable mcrypt

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

COPY ./php.ini /usr/local/etc/php/conf.d/php.ini

#PDF生成组件
COPY ./wkhtmltox_0.12.5-1.buster_amd64.deb /tmp/wkhtmltox_0.12.5-1.buster_amd64.deb
RUN dpkg -i /tmp/wkhtmltox_0.12.5-1.buster_amd64.deb; exit 0 
RUN  apt -y -f install && \
    dpkg -i /tmp/wkhtmltox_0.12.5-1.buster_amd64.deb

   #安装PDF字体
RUN mkdir -p /usr/share/fonts/chinese/TrueType/ && wget https://h947136.coding.net/api/share/download/425b2c4b-fdac-47fe-989d-e1487b018215 -O /usr/share/fonts/chinese/TrueType/simsun.ttc
RUN wget https://h947136.coding.net/api/share/download/90fe9a74-a042-4ee3-a8a4-4e02881c0708  -O /usr/share/fonts/truetype/FZHTJW.TTF

#WORKDIR /var/www/html

RUN apt-get install cron -y
RUN apt-get install rsyslog -y

COPY ./crontab /tmp

RUN cat /tmp/crontab >> /etc/crontab

RUN sed -i '/session    required     pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/cron

#CMD ["sh", "-c", "service rsyslog start ; tail -f /dev/null"]
CMD ["sh", "-c", "service rsyslog restart; service cron restart ; tail -f /dev/null"]
