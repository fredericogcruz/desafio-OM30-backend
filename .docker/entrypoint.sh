#!/bin/bash

set -e


echo " \033[01;31m # Copiando arquivo default para nginx...                                     "
cp default /etc/nginx/sites-available/default



echo " \033[01;31m # Setando permissões de arquivos...                                          "
chmod -R 777 /var/www/html



echo " \033[01;31m # Setando permissões de arquivos...                                          "
if [ -d "/var/www/html/vendor" ]; then
    echo "Diretório vendor já existe!"
else 
    if [ ! -f "/var/www/html/composer.phar" ]; then
        echo " \033[01;31m # Baixando composer.phar...                                          "
        wget https://getcomposer.org/download/2.0.0/composer.phar /var/www/html
    fi
    
    echo " \033[01;31m # Setando permissões de arquivos...                                      "
    chmod +x /var/www/html/composer.phar

    echo " \033[01;31m # Executando composer.phar update...                                     "
    /var/www/html/composer.phar install --ignore-platform-reqs 
fi



echo " \033[01;31m # Setando permissões de arquivos... "
chmod -R 775 /var/www/html
chmod -R 777 /var/www/html/storage/




echo " \033[01;31m # Grava arquivo .env "
echo "
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=pgsql
DB_HOST=desafio-om30_db_1
DB_PORT=5432
DB_DATABASE=postgres
DB_USERNAME=postgres
DB_PASSWORD=postgres

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DRIVER=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS=null
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_APP_CLUSTER=mt1

MIX_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
MIX_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
" > .env


echo " \033[01;31m # key generate "
php artisan key:generate


echo " \033[01;31m # migrate "
php artisan migrate:fresh
php artisan migrate


echo " \033[01;31m # Seed "
php artisan db:seed


echo " \n\n\n "
echo " \033[01;33m###################################################################\033[01;33m"
echo " \033[05;41m                          P R O N T O ! ! !                        \033[05;41m"
echo " \033[01;33m###################################################################\033[01;33m \n"
echo " \033[01;31m ## Para acessar a aplicacao >>>  http://localhost:8081/ \033[01;31m\n"
echo " \033[01;31m ## Para acessar PgAdmin >>>  http://localhost:16543/ \033[01;31m\n"
echo " \033[01;33m###################################################################\033[01;33m"
nginx -g 'daemon off;'



exec "$@"