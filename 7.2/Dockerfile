FROM php:7.2-fpm-alpine

RUN apk add --no-cache --virtual .build-deps \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev

RUN docker-php-ext-install \
    bcmath \
    mbstring \
	mysqli \
	opcache \
    exif

RUN docker-php-ext-enable \
    bcmath \
    mbstring \
    mysqli \
	opcache \
    exif

RUN apk add --no-cache --update \
    php7-xml \
    php7-xmlreader \
    php7-ftp \
    php7-json \
    php7-curl \
    php7-sockets \
    php7-zlib \
    php7-phar \
    php7-openssl \
    php7-zip \
    php7-dev \
    php7-exif \
    php7-fileinfo \
    php7-redis \
    mysql-client

RUN apk add --update --no-cache autoconf g++ libtool make pcre-dev imagemagick imagemagick-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool make \
    && rm -rf /tmp/* /var/cache/apk/*

RUN { \
    echo 'opcache.memory_consumption=128'; \
	echo 'opcache.interned_strings_buffer=8'; \
	echo 'opcache.max_accelerated_files=4000'; \
	echo 'opcache.revalidate_freq=2'; \
	echo 'opcache.fast_shutdown=1'; \
	echo 'opcache.enable_cli=1'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN apk del --purge \
    *-dev

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY adminer/init.php /var/www/adminer/index.php

ADD init.sh /usr/local/bin/
	
VOLUME /var/www/html
VOLUME /var/www/adminer

ENTRYPOINT ["init.sh"]

CMD ["php-fpm"]

EXPOSE 9000