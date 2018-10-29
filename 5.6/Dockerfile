FROM php:5.6-fpm-alpine

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
    php5-xml \
    php5-xmlreader \
    php5-ftp \
    php5-json \
    php5-curl \
    php5-sockets \
    php5-zlib \
    php5-phar \
    php5-openssl \
    php5-zip \
    php5-dev \
    php5-exif \
    php5-mcrypt \
    php5-opcache \
    mysql-client

RUN apk add --update --no-cache autoconf g++ libtool make pcre-dev imagemagick imagemagick-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool make \
    && rm -rf /tmp/* /var/cache/apk/*

RUN apk del --purge \
    *-dev

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

ADD init.sh /usr/local/bin/
	
VOLUME /var/www/html

ENTRYPOINT ["init.sh"]

CMD ["php-fpm"]

EXPOSE 9000