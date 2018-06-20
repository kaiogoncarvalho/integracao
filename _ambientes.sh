#!/bin/bash
#!/usr/bin/env bash

# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
#Variáveis do ENV
ENV=./.env
#Env Example
ENV_EXAMPLE=./example.env
# Configuração da Api Apartada

INTEGRACAO_DIR=$(pwd)

. $HELPERS

# Inicializa as funções de configuração dos projetos
main() {
  while true;
  do
    printInBar "CONFIGURAÇÃO DE PROJETOS - PRAVALER"
    printLine "1 - Instalar Ambientes"
    printLine "2 - Instalar Ambientes Neo"
    printLine "3 - Alterar Banco de Dados"
    printInBar "S - Sair"
    read -p "| Informe a opção desejada >_ " OPTION
    lineDelimiter
    case $OPTION in
      0) clear
        printInBar "Execução finalizada!"
        exit
      ;;
      1) clear
        printInBar "AMBIENTES"
        printLine "1 - Backoffice"
        printLine "2 - CDN"
        printLine "3 - API Pravaler"
        printLine "0 - Voltar"
        printInBar "S - Sair"
        read -p "| Informe a opção desejada >_ " OPTION

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
