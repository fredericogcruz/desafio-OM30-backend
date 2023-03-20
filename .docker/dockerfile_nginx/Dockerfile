# docker/Dockerfile
FROM debian:11-slim

ARG APCU_VERSION=5.1.18

RUN apt-get update && apt-get install -y \
    build-essential \
    libicu-dev \
    libzip-dev \
    libpng-dev \
    libfreetype6-dev \
    libonig-dev \
    locales \
    zip \
    unzip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    git \
    curl \
    wget 

RUN apt-get update && apt-get install -y \
        vim \
        htop \
        sudo \
        git

RUN apt-get update && apt-get install -y 

RUN sudo apt-get install -y software-properties-common

RUN sudo apt-get install php-pear -y

RUN sudo apt-get install php-dev -y

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PUID ${PUID}

ARG PGID=1000

RUN sudo apt-get install -y curl wget ca-certificates lsb-release apt-transport-https

RUN wget https://packages.sury.org/php/apt.gpg

RUN sudo apt-key add apt.gpg

RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php7.list

RUN sudo apt update

RUN sudo apt install -y php7.4 php7.4-cli php7.4-common

RUN apt install php7.4-curl zip unzip php7.4-xml php7.4-mbstring -y

RUN apt-get install php7.4-pgsql -y

RUN apt-get install postgresql-client -y 

RUN apt-get install nginx -y

RUN chown -R www-data:www-data /var/www

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
EXPOSE 22
EXPOSE 21
EXPOSE 443