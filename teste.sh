#!/bin/bash
#!/usr/bin/env bash

# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
#Variáveis do ENV
ENV=./.env
#Env Example
ENV_EXAMPLE=./example.env
# Configuração dos Outros Sistemas
OUTROS=./Menu/outros.sh
# Configuração dos Sistemas Neo
NEO=./Menu/neo.sh
# Configuração do Banco de Dados
DATABASE=./Menu/database.sh
# Configuração do Nginx
NGINX_SH=./DockerFiles/Nginx/Files/nginx.sh

INTEGRACAO_DIR=$(pwd)

. $HELPERS
. $OUTROS
. $NEO
. $DATABASE
. $NGINX_SH
. $ENV

if isValidInstall 'BACKOFFICE' ;
then
    echo 'valido';
else
    echo 'invalido'
fi
