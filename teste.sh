#!/bin/bash
#!/usr/bin/env bash

# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
#Variáveis do ENV
ENV=./.env
#Env Example
ENV_EXAMPLE=./example.env
# Configuração dos Outros Sistemas
# Configuração dos Sistemas Neo
NEO=./Menu/neo.sh
# Configuração do Banco de Dados
DATABASE=./Menu/database.sh
# Configuração do Nginx
NGINX_SH=./DockerFiles/Nginx/Files/nginx.sh

INTEGRACAO_DIR=$(pwd)

. $HELPERS
. $NEO
. $DATABASE
. $NGINX_SH
. $ENV

sed -i -E "s/(define[(]'ENVIRONMENT'[ ]*,[ ]*?')(.*?)(')/\1dds\3/g" $NEO_CONFIG