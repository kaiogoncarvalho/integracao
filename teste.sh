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
array=( "PORTALPRAVALER" "NOVAPROPOSTA_FRONTEND" "RETORNO_MEC" "APIPRAVALER" "NEO_LOG" "NEO_BPM" "NEO_OAUTH" )

declare -A envs

envs[0,0]="PORTALPRAVALER"
    envs[0,1]="portal.domain="
    envs[0,2]=$PORTALPRAVALER_URL

    envs[1,0]="NOVAPROPOSTA_FRONTEND"
    envs[1,1]="proposta2017.path="
    envs[1,2]="http://$NOVAPROPOSTA_FRONTEND_URL/app/\#/finalize"

    envs[2,0]="RETORNO_MEC"
    envs[2,1]="retorno.mec="
    envs[2,2]="http://$RETORNO_MEC_URL"

    envs[3,0]="APIPRAVALER"
    envs[3,1]="api.aprovacaoIes.path="
    envs[3,2]="http://$APIPRAVALER_URL/v1.1"

    envs[4,0]="NEO_LOG"
    envs[4,1]="neo.log="
    envs[4,2]="http://$NEO_LOG_URL"

    envs[5,0]="NEO_BPM"
    envs[5,1]="neo.log="
    envs[5,2]="http://$NEO_BPM_URL"

echo "${envs[2,0]}"

for a in 1 2 3 4 5
do
         echo "${envs[$a,0]}"
         echo $a
done

