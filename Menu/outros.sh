#!/bin/bash
#!/usr/bin/env bash
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
# Configuração do Nginx
NGINX_SH=./DockerFiles/Nginx/Files/nginx.sh
# Configuração do frontend da proposta nova
NOVA_PROPOSTA_FRONTEND_SH=./DockerFiles/NovaPropostaFrontEnd/Files/nova_proposta_frontend.sh
# Configuração do ftp risco cobranca
FTP_RISCO_COBRANCA_SH=./DockerFiles/FtpRiscoCobranca/Files/ftp_risco_cobranca.sh
# Configuração do Seguros
SEGUROS_SH=./DockerFiles/Seguros/Files/setup_seguros.sh
# Configuração do Retorno Mec
RETORNO_MEC_SH=./DockerFiles/RetornoMec/Files/retorno_mec.sh
# Configuração do Marketplace
MARKETPLACE_API_SH=./DockerFiles/Marketplace/Files/setup_marketplace_api.sh

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
. $RETORNO_MEC_SH
. $MARKETPLACE_API_SH


# Inicializa as funções de configuração dos projetos
outros() {
    while true;
    do
        printInBar "Ambientes Pravaler" "verde"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        printInBar "Ambientes" "verde"
        printLine "1  - Agendamento de Homologação"
        printLine "2  - Api Apartada"
        printLine "3  - Api Pravaler"
        printLine "4  - Backoffice"
        printLine "5  - CDN"
        printLine "6  - CreditScore"
        printLine "7  - FTP Risco e Cobrança"
        printLine "8  - Marketplace"
        printLine "9  - Nova Proposta Backend"
        printLine "10 - Nova Proposta Frontend"
        printLine "11 - Portal Pravaler"
        printLine "12 - Retorno Mec"
        printLine "13 - Seguros"

        printLine "0  - Voltar" "branco" "negrito"
        printInBar "s - Sair" "vermelho"
        read -p "| Informe a opção desejada >_ " OPTION

        clear

        case $OPTION in
          'S')
              printInBar "Execução finalizada!"
              exit
          ;;
          's')
              printInBar "Execução finalizada!"
              exit
          ;;
          0) break
          ;;
          1) installSystem "Agendamento de Homologação" "AGENDAMENTO" "setup_agendamento"
          ;;
          2) installSystem "Api Apartada" "APIAPARTADA" "setup_api_apartada"
          ;;
          3) installSystem "Api Pravaler" "APIPRAVALER" "setup_api_pravaler"
          ;;
          4) installSystem "Backoffice" "BACKOFFICE" "setup_backoffice"
          ;;
          5) installSystem "CDN" "CDN" "setup_cdn"
          ;;
          6) installSystem "CreditScore" "CREDITSCORE" "setup_credit_score"
          ;;
          7)
            msgGeneral "\nComeçando configuração do FTP Risco e Cobrança:\n" 'verde' 'negrito'

            configEnvIntegracao 'example.env'
            createNetwork
            reloadEnv
            setup_ftp_risco_cobranca
          ;;
          8) installSystem "Marketplace Api" "MARKETPLACE_API" "setup_marketplace_api"
          ;;
          9) installSystem "Nova Proposta Backend" "NOVAPROPOSTA_BACKEND" "setup_nova_proposta_backend"
          ;;
          10) installSystem "Nova Proposta Frontend" "NOVAPROPOSTA_FRONTEND" "setup_nova_proposta_frontend"
          ;;
          11) installSystem "Portal Pravaler" "PORTALPRAVALER" "setup_portal_pravaler"
          ;;
          12) installSystem "Retorno Mec" "RETORNO_MEC" "retorno_mec"
          ;;
          13) installSystem "Seguros" "SEGUROS" "setup_seguros"
          ;;

          *) clear
            printInBar "Opção inválida!" "vermelho"
          ;;

        esac

         if [ $TIPO_INSTALACAO == "servidor" ];
         then
            echo -e "\nConfigurando Nginx:\n"
            reloadEnv
            setup_nginx
        fi

    done

}
