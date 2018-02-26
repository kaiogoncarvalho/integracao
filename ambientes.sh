#!/usr/bin/env bash

INTEGRACAO_DIR=$(pwd)

#Variáveis do ENV
ENV=./.env
# Configuração da Api Apartada
APIAPARTADA_SH=./DockerFiles/ApiApartada/Files/api_apartada.sh
# Configuração da Api Pravaler
APIPRAVALER_SH=./DockerFiles/ApiPravaler/Files/api_pravaler.sh
# Configuração do Backoffice
BACKOFFICE_SH=./DockerFiles/Backoffice/Files/backoffice.sh
# Configuração do CreditScore
CREDITSCORE_SH=./DockerFiles/CreditScore/Files/credit_score.sh
# Configuração do Portal Pravaler
PORTALPRAVALER_SH=./DockerFiles/PortalPravaler/Files/portalpravaler.sh
# Configuração da Nova Proposta - Backend
NOVAPROPOSTA_BACKEND_SH=./DockerFiles/NovaPropostaBackend/Files/nova_proposta_backend.sh
# Configuração do CDN
CDN_SH=./DockerFiles/CDN/Files/cdn.sh
# Configuração do Agendamento de homologação
AGENDAMENTO_SH=./DockerFiles/Agendamento/Files/agendamento.sh
# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
# Configuração do Nginx
NGINX_SH=./DockerFiles/Nginx/Files/nginx.sh
# Configuração do frontend da proposta nova
NOVA_PROPOSTA_FRONTEND_SH=./DockerFiles/NovaPropostaFrontEnd/Files/nova_proposta_frontend.sh

. $APIPRAVALER_SH
. $APIAPARTADA_SH
. $BACKOFFICE_SH
. $CREDITSCORE_SH
. $PORTALPRAVALER_SH
. $CDN_SH
. $NOVAPROPOSTA_BACKEND_SH
. $NOVA_PROPOSTA_FRONTEND_SH
. $AGENDAMENTO_SH
. $HELPERS
. $NGINX_SH



# Inicializa as funções de configuração dos projetos
main() {

    msgGeneral '\n\t\tIniciando configuração dos ambientes: \n' 'verde' 'negrito'

    configInitialEnv 'example.env'

    . $ENV

    configRepository "CDN" "CDN" "setup_cdn"

    configRepository "Backoffice" "BACKOFFICE" "setup_backoffice"

    configRepository "Portal Pravaler" "PORTALPRAVALER" "setup_portal_pravaler"

    configRepository "Api Pravaler" "APIPRAVALER" "setup_api_pravaler"

    configRepository "Api Apartada" "APIAPARTADA" "setup_api_apartada"

    configRepository "CreditScore" "CREDITSCORE" "setup_credit_score"

    configRepository "Agendamento de Homologação" "AGENDAMENTO" "setup_agendamento"

    configRepository "Nova Proposta Backend" "NOVAPROPOSTA_BACKEND" "setup_nova_proposta_backend"

    configRepository "Nova Proposta Frontend" "NOVAPROPOSTA_FRONTEND" "setup_nova_proposta_frontend"


    if [ $TIPO_INSTALACAO == "servidor" ];
    then
        echo -e "\nConfigurando Nginx:\n"
        reloadEnv
        setup_nginx
    fi

}

main
