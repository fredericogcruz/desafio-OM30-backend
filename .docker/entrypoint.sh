#!/bin/bash

set -e


echo " \033[01;31m # Copiando arquivo default para nginx...                                     "
cp default /etc/nginx/sites-available/default



echo " \033[01;31m # Setando permissões de arquivos...                                          "
chmod -R 777 /var/www/html



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
    php artisan key:generate
fi



echo " \033[01;31m # Setando permissões de arquivos... "
chmod -R 775 /var/www/html
chmod -R 777 /var/www/html/storage/



echo " \033[01;33m###################################################################\033[01;33m"
echo " \033[01;31m # CONTAINERS INICIALIZADOS! :-) "
echo " \033[01;33m###################################################################\033[01;33m"
echo " \033[05;41m ## Para acessar a aplicacao >>>  http://localhost:8081/ \033[01;30m\n"
echo " \033[05;41m ## Para acessar PgAdmin >>>  http://localhost:16543/ \033[01;30m\n"
echo " \033[01;33m###################################################################\033[01;33m"
nginx -g 'daemon off;'



exec "$@"