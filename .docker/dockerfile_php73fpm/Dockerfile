FROM php:7-fpm-stretch
RUN apt-get update
RUN apt-get install -y libpdflib804-2-dev --force-yes
RUN set -ex && \
    cd /tmp && \
    export PHP_EXT_DIR=$(php-config --extension-dir) && \
    curl -o pdflib.tar.gz https://www.pdflib.com/binaries/PDFlib/920/PDFlib-9.2.0-Linux-x86_64-php.tar.gz -L && \
    tar -xvf pdflib.tar.gz && \
    mv PDFlib-* pdflib && cd pdflib && \
    cp bind/php/php-730-nts/php_pdflib.so $PHP_EXT_DIR && \
    docker-php-ext-enable php_pdflib && \
    rm -rf /tmp/*
CMD ["php-fpm"]