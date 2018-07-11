#!/usr/bin/env bash
#Variáveis do ENV
ENV=./.env
#Env Example
ENV_EXAMPLE=./example.env
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
# Configuração do ftp risco cobranca
FTP_RISCO_COBRANCA_SH=./DockerFiles/FtpRiscoCobranca/Files/ftp_risco_cobranca.sh
# Configuração do Seguros
SEGUROS_SH=./DockerFiles/Seguros/Files/setup_seguros.sh

. $HELPERS
. $APIPRAVALER_SH
. $APIAPARTADA_SH
. $BACKOFFICE_SH
. $CREDITSCORE_SH
. $PORTALPRAVALER_SH
. $CDN_SH
. $NOVAPROPOSTA_BACKEND_SH
. $NOVA_PROPOSTA_FRONTEND_SH
. $FTP_RISCO_COBRANCA_SH
. $AGENDAMENTO_SH
. $NGINX_SH
. $SEGUROS_SH



# Inicializa as funções de configuração dos projetos
main() {

    msgGeneral '\n\t\tIniciando configuração dos ambientes: \n' 'verde' 'negrito'

    configEnvIntegracao 'example.env'

    createNetwork

    configRepository "CDN" "CDN" "setup_cdn"

    configRepository "Backoffice" "BACKOFFICE" "setup_backoffice"

    configRepository "Portal Pravaler" "PORTALPRAVALER" "setup_portal_pravaler"

    configRepository "Api Pravaler" "APIPRAVALER" "setup_api_pravaler"

    configRepository "Api Apartada" "APIAPARTADA" "setup_api_apartada"

    configRepository "CreditScore" "CREDITSCORE" "setup_credit_score"

    configRepository "Agendamento de Homologação" "AGENDAMENTO" "setup_agendamento"

    configRepository "Nova Proposta Backend" "NOVAPROPOSTA_BACKEND" "setup_nova_proposta_backend"

    configRepository "Nova Proposta Frontend" "NOVAPROPOSTA_FRONTEND" "setup_nova_proposta_frontend"

    if isVerifyConfig "Ftp Risco Cobrança"
    then
        setup_ftp_risco_cobranca
    fi

    configRepository "Seguros" "SEGUROS" "setup_seguros"

    if [ $TIPO_INSTALACAO == "servidor" ];
    then
        echo -e "\nConfigurando Nginx:\n"
        reloadEnv
        setup_nginx
    fi

}

main
