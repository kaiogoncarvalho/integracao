#!/bin/bash
#!/usr/bin/env bash

if [  -h '/bin/integracao' ]; then
    ACTUAL_FILE=$(realpath /bin/integracao)
    ACTUAL_DIR=$(echo $ACTUAL_FILE | grep -oP ".*\/")
    cd $ACTUAL_DIR
fi

INTEGRACAO_DIR=$(pwd)

# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
#Variáveis do ENV
ENV=$INTEGRACAO_DIR/.env
#Env Example
ENV_EXAMPLE=$INTEGRACAO_DIR/example.env
# Configuração dos Outros Sistemas
SISTEMAS=./Menu/sistemas.sh
# Configuração dos Sistemas Neo
NEO=./Menu/neo.sh
# Configuração do Banco de Dados
DATABASE=./Menu/database.sh
# Configuração do Detalhe
DETALHE_SH=./Menu/detalhe.sh
# Configuração do Tipo de Instalação
CONFIG_INSTALACAO_SH=./Menu/config_instalacao.sh
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
# Configuração do Oauth
OAUTH_SH=./DockerFiles/Neo/Oauth/Files/oauth.sh
# Configuração do BPM
BPM_SH=./DockerFiles/Neo/BPM/Files/bpm.sh
#ENV das URLS
ENV_URL=./url.env


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
. $DETALHE_SH
. $OAUTH_SH
. $BPM_SH
. $CONFIG_INSTALACAO_SH
. $ENV_URL

verifySudo

# Inicializa as funções de configuração dos projetos
main() {
    configEnvIntegracao 'example.env'
    createNetwork
    clear

  while true;
  do

    clear

    printInBar "Ambientes Pravaler" "ciano"
    echo -e
    printInBar "Criado por Kaio Gonçalves Carvalho"
    echo -e
    printInBar "Menu" "verde"
    printLine "1 - Ambientes"
    printLine "2 - Ambientes Neo"
    printLine "3 - Banco De Dados"
    printLine "4 - Configurações de Instalação"
    printInBar "s - Sair" "vermelho"
    read -p "| Informe a opção desejada >_ " OPTION

    clear

    case $OPTION in
      's')
        clear
        printInBar "Execução finalizada!" 'verde'
        exit
      ;;
      'S')
        clear
        printInBar "Execução finalizada!" 'verde'
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
      4)
        configInstalacao
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
