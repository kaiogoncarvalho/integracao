#!/bin/bash
#!/usr/bin/env bash

# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
#Variáveis do ENV
ENV=./.env
#Env Example
ENV_EXAMPLE=./example.env
# Configuração dos Outros Sistemas
SISTEMAS=./Menu/sistemas.sh
# Configuração dos Sistemas Neo
NEO=./Menu/neo.sh
# Configuração do Banco de Dados
DATABASE=./Menu/database.sh
# Configuração do Nginx
NGINX_SH=./DockerFiles/Nginx/Files/nginx.sh
# Configuração padrão para instalação de serviço
SERVICE_SH=./DockerFiles/Neo/service.sh
# Configuração do Serviço de Negociação de acordos
ALFRED_CLIENT_SH=./DockerFiles/Neo/AlfredClient/Files/alfred_client.sh
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
. $SEGUROS_SH
. $RETORNO_MEC_SH
. $MARKETPLACE_API_SH
. $HELPERS
. $SISTEMAS
. $NEO
. $DATABASE
. $NGINX_SH
. $SERVICE_SH
. $ALFRED_CLIENT_SH

INTEGRACAO_DIR=$(pwd)


# Inicializa as funções de configuração dos projetos
main() {
    configEnvIntegracao 'example.env'
    createNetwork
    clear

  while true;
  do
    clear


    printInBar "Ambientes Pravaler" "verde"
    echo -e
    printInBar "Criado por Kaio Gonçalves Carvalho"
    echo -e
    printInBar "Menu" "verde"
    printLine "1 - Instalar Ambientes"
    printLine "2 - Instalar Ambientes Neo"
    printLine "3 - Alterar Banco de Dados usado nas instalações"
    printInBar "s - Sair" "vermelho"
    read -p "| Informe a opção desejada >_ " OPTION

    clear

    case $OPTION in
      's')
        clear
        printInBar "Execução finalizada!"
        exit
      ;;
      'S')
        clear
        printInBar "Execução finalizada!"
        exit
      ;;
      1)
        sistemas
      ;;
      2)
        neo
      ;;
      3)
        database
      ;;
      *) clear
        printInBar "Opção inválida!"
      ;;
    esac
    clear
    printInBar "Fim da operação."
    echo -e
  done

}

main
