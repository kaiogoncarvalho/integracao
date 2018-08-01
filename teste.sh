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

grep -Pzo "(?s)(\'database\'\s*=>\s*array\s*\(.*?\'backoffice\'\s*=>\s*array\s*\([^)]*?\'port\'\s*=>\s*\')([\d]*)" $NEO_CONFIG
echo -e

#sed -n  "s/(database)/\1/p" $NEO_CONFIG
