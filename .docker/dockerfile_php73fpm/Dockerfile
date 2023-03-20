FROM php:7-fpm-stretch

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
            curl libcurl3 libcurl4-openssl-dev libssl-dev libc-client-dev libkrb5-dev \
            libpcre3 libpcre3-dev libmagickwand-dev libmemcached-dev zlib1g-dev \
            libpq-dev nghttp2 libnghttp2-dev --no-install-recommends && \
    apt-get clean && apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -ex && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    : && \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install imap && \
    : && \
    docker-php-ext-configure opcache --enable-opcache && \
    docker-php-ext-install opcache && \
    : && \
    docker-php-ext-install bcmath calendar exif gettext intl pspell pcntl bz2 zip && \
    docker-php-ext-install shmop soap sockets sysvmsg sysvsem sysvshm wddx xsl xmlrpc 

RUN apt-get install -y libpq-dev \
  && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-install pdo pdo_pgsql pgsql

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


# PDFlib
# https://www.pdflib.com/download/pdflib-product-family/
RUN set -ex && \
    cd /tmp && \
    export PHP_EXT_DIR=$(php-config --extension-dir) && \
    curl -o pdflib.tar.gz https://www.pdflib.com/binaries/PDFlib/931/PDFlib-9.3.1p5-Linux-aarch64-php.tar.gz -L && \
    tar -xvf pdflib.tar.gz && \
    mv PDFlib-* pdflib && cd pdflib && \
    cp bind/php/php-730-nts/php_pdflib.so $PHP_EXT_DIR && \
    docker-php-ext-enable php_pdflib && \
    rm -rf /tmp/*

COPY . /var/www/html
