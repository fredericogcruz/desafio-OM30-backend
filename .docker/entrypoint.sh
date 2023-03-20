#!/bin/bash

set -e


cp default /etc/nginx/sites-available/default


echo " \033[01;33m===================================================================\033[01;33m"
echo " \033[01;31m  NGINX API Server "
echo " \033[01;33m===================================================================\033[01;33m"
echo " \n\033[05;41m ## Para acessar a aplicação >>>  http://localhost:8081/ \033[01;30m\n\n\n"
echo " \n\033[05;41m ## Para acessar PgAdmin >>>  http://localhost:16543/ \033[01;30m\n\n\n"
echo " \033[01;33m===================================================================\033[01;33m"


nginx -g 'daemon off;'



exec "$@"