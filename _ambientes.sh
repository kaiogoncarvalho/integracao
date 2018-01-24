#!/bin/bash
#!/usr/bin/env bash

# Importação das funções que serão usadas na aplicação
HELPERS=helpers.sh
. $HELPERS

INTEGRACAO_DIR=$(pwd)

#Variáveis do ENV
# ENV=./.env
# . $ENV

# Configuração da Api Apartada
APIAPARTADA_SH=./DockerFiles/ApiApartada/Files/api_apartada.sh
. $APIAPARTADA_SH

# Configuração da Api Pravaler
APIPRAVALER_SH=./DockerFiles/ApiAprovacao/Files/api_pravaler.sh
. $APIPRAVALER_SH

# Configuração do Backoffice
BACKOFFICE_SH=./DockerFiles/Backoffice/Files/backoffice.sh
. $BACKOFFICE_SH

# Configuração do CreditScore
CREDITSCORE_SH=./DockerFiles/CreditScore/Files/credit_score.sh
. $CREDITSCORE_SH

# Configuração do Portal Pravaler
PORTALPRAVALER_SH=./DockerFiles/PortalPravaler/Files/portalpravaler.sh
. $PORTALPRAVALER_SH

# Inicializa as funções de configuração dos projetos
main() {
  while true;
  do
    printInBar "CONFIGURAÇÃO DE PROJETOS - IDEAL INVEST"
    printLine "1 - Instalar ambientes"
    printLine "  1.1 - Backoffice"
    printLine "  1.2 - Portal Pravaler"
    printLine "  1.3 - Credit Score"
    printLine "  1.4 - API Apartada"
    printLine "  1.5 - API Aprovação"
    printInBar "0 - Sair"
    read -p "| Informe a opção desejada >_ " OPTION
    lineDelimiter
    case $OPTION in
      0) clear
        printInBar "Execução finalizada!"
        exit
      ;;
      1) clear
        printInBar "Instalando TODOS os projetos"
        # performSetup "func" "TESTE"
      ;;
      "1.1") clear
        lineDelimiter
        read -p "| Informe o diretório de instalação do Backoffice >_ " BACKOFFICE_LOCAL
        lineDelimiter
        # if isValidRepository $BACKOFFICE_LOCAL; then
        #   printInBar "Configurando o Backoffice em '${BACKOFFICE_LOCAL}'"
        #   # setup_backoffice
        # else
        #   printInBar "ERRO: O diretório informado não é válido!"
        # fi
        performSetup "setup_backoffice" BACKOFFICE_LOCAL
      ;;
      "1.2") clear
        lineDelimiter
        read -p "| Informe o diretório de instalação do Portal Pravaler >_ " PORTALPRAVALER_LOCAL
        lineDelimiter
        # if isValidRepository $PORTALPRAVALER_LOCAL; then
        #   printInBar "Instalando o Portal Pravaler em '${PORTALPRAVALER_LOCAL}'"
        #   # setup_portal_pravaler
        # else
        #   printInBar "ERRO: O diretório informado não é válido!"
        # fi
        performSetup "setup_portal_pravaler" PORTALPRAVALER_LOCAL
      ;;
      "1.3") clear
        lineDelimiter
        read -p "| Informe o diretório de instalação do Credit Score >_ " CREDITSCORE_LOCAL
        lineDelimiter
        # if isValidRepository $CREDITSCORE_LOCAL; then
        #   printInBar "Instalando o Credit Score em '${CREDITSCORE_LOCAL}'"
        #   # setup_credit_score
        # else
        #   printInBar "ERRO: O diretório informado não é válido!"
        # fi
        performSetup "setup_credit_score" CREDITSCORE_LOCAL
      ;;
      "1.4") clear
        lineDelimiter
        read -p "| Informe o diretório de instalação do API Apartada >_ " APIAPARTADA_LOCAL
        lineDelimiter
        # if isValidRepository $APIAPARTADA_LOCAL; then
        #   printInBar "Instalando a API Apartada em '${APIAPARTADA_LOCAL}'"
        #   # setup_api_apartada
        # else
        #   printInBar "ERRO: O diretório informado não é válido!"
        # fi
        performSetup "setup_api_apartada" APIAPARTADA_LOCAL
      ;;
      "1.5") clear
        lineDelimiter
        read -p "| Informe o diretório de instalação do API Aprovação >_ " APIPRAVALER_LOCAL
        lineDelimiter
        # if isValidRepository $APIPRAVALER_LOCAL; then
        #   printInBar "Instalando a API Aprovação em '${APIPRAVALER_LOCAL}'"
        #   # setup_api_pravaler
        # else
        #   printInBar "ERRO: O diretório informado não é válido!"
        # fi
        performSetup "setup_api_pravaler" APIPRAVALER_LOCAL
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
