FROM php:7.4-fpm

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Brazil/West
RUN set -ex && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

RUN set -ex && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libicu-dev \
            libxml2-dev libxslt-dev libzip-dev libbz2-dev libpspell-dev aspell-en \
            curl libcurl4-openssl-dev libssl-dev libc-client-dev libkrb5-dev \
            libpcre3 libpcre3-dev libmagickwand-dev libmemcached-dev zlib1g-dev \
            libpq-dev nghttp2 libnghttp2-dev --no-install-recommends && \
            apt-get clean && apt-get autoclean && apt-get autoremove && \
            rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -ex && \
    docker-php-ext-configure gd && \
    docker-php-ext-install gd && \
    : && \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install imap && \
    : && \
    docker-php-ext-configure opcache --enable-opcache && \
    docker-php-ext-install opcache && \
    : && \
    docker-php-ext-install bcmath calendar exif gettext intl pspell pcntl bz2 zip && \
    docker-php-ext-install shmop soap sockets sysvmsg sysvsem sysvshm xsl xmlrpc 

RUN apt-get install -y libpq-dev \
  && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-install pdo pdo_pgsql pgsql

RUN apt-get install gcc make

# Common
RUN apt-get update \
	&& apt-get install -y \
		openssl \
		git \
		gnupg2

# PHP
# intl
RUN apt-get update \
	&& apt-get install -y libicu-dev \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install -j$(nproc) intl

# xml
RUN apt-get update \
	&& apt-get install -y \
	libxml2-dev \
	libxslt-dev \
	&& docker-php-ext-install -j$(nproc) \
		dom \
		xmlrpc \
		xsl

# images
RUN apt-get update \
	&& apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libpng-dev \
	libgd-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) \
		gd \
		exif

# database
RUN docker-php-ext-install -j$(nproc) \
	mysqli \
	pdo \
	pdo_mysql

# strings
RUN apt-get update \
    && apt-get install -y libonig-dev \
    && docker-php-ext-install -j$(nproc) \
	    gettext \
	    mbstring

# math
RUN apt-get update \
	&& apt-get install -y libgmp-dev \
	&& ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
	&& docker-php-ext-install -j$(nproc) \
		gmp \
		bcmath

# compression
RUN apt-get update \
	&& apt-get install -y \
	libbz2-dev \
	zlib1g-dev \
	libzip-dev \
	&& docker-php-ext-install -j$(nproc) \
		zip \
		bz2

# ftp
RUN apt-get update \
	&& apt-get install -y \
	libssl-dev \
	&& docker-php-ext-install -j$(nproc) \
		ftp

# ssh2
RUN apt-get update \
	&& apt-get install -y \
	libssh2-1-dev

# memcached
RUN apt-get update \
	&& apt-get install -y \
	libmemcached-dev \
	libmemcached11


# others
RUN docker-php-ext-install -j$(nproc) \
	soap \
	sockets \
	calendar \
	sysvmsg \
	sysvsem \
	sysvshm

# PECL
#RUN docker-php-pecl-install \
#	ssh2-1.2 \
#	redis-5.1.1 \
#	apcu-5.1.18 \
#	memcached-3.1.4

# Install XDebug, but not enable by default. Enable using:
# * php -d$XDEBUG_EXT vendor/bin/phpunit
# * php_xdebug vendor/bin/phpunit
RUN pecl install xdebug-2.8.0
ENV XDEBUG_EXT zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20190902/xdebug.so
RUN alias php_xdebug="php -d$XDEBUG_EXT vendor/bin/phpunit"

# Install composer and put binary into $PATH
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# Install PHP Code sniffer
RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
	&& chmod 755 phpcs.phar \
	&& mv phpcs.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcs.phar /usr/local/bin/phpcs \
	&& curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar \
	&& chmod 755 phpcbf.phar \
	&& mv phpcbf.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpcbf.phar /usr/local/bin/phpcbf

# Install PHPUnit
RUN curl -OL https://phar.phpunit.de/phpunit.phar \
	&& chmod 755 phpunit.phar \
	&& mv phpunit.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/phpunit.phar /usr/local/bin/phpunit

# Redis
RUN apt-get update \
	&& apt-get install -y redis-server

EXPOSE 6379

# Clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*ysvsem sysvshm xsl xmlrpc 

# set recommended opcache settings
# https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
		echo 'opcache.file_cache=/tmp'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# remove PHP version from the X-Powered-By HTTP header
# test: curl -I -H "Accept-Encoding: gzip, deflate" https://www.yourdomain.com
RUN echo 'expose_php = off' > /usr/local/etc/php/conf.d/hide-header-version.ini

COPY . /var/www/html