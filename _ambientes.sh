#!/bin/bash
#!/usr/bin/env bash

# Importação das funções que serão usadas na aplicação
HELPERS=helpers.sh
. $HELPERS

INTEGRACAO_DIR=$(pwd)

#Variáveis do ENV
ENV=./.env
# Configuração da Api Apartada
APIAPARTADA_SH=./DockerFiles/ApiApartada/Files/api_apartada.sh
# Configuração da Api de Aprovação
APIAPROVACAO_SH=./DockerFiles/ApiAprovacao/Files/api_aprovacao.sh
# Configuração do Backoffice
BACKOFFICE_SH=./DockerFiles/Backoffice/Files/backoffice.sh
# Configuração do CreditScore
CREDITSCORE_SH=./DockerFiles/CreditScore/Files/credit_score.sh
# Configuração do Portal Pravaler
PORTALPRAVALER_SH=./DockerFiles/PortalPravaler/Files/portalpravaler.sh

. $ENV
. $APIAPROVACAO_SH
. $APIAPARTADA_SH
. $BACKOFFICE_SH
. $CREDITSCORE_SH
. $PORTALPRAVALER_SH

# Inicializa as funções de configuração dos projetos
main() {
  while true;
  do
    printHeader "CONFIGURAÇÃO DE PROJETOS - IDEAL INVEST"
    printLine "  1 - Instalar ambientes"
    printLine "    1.1 - Backoffice"
    printLine "    1.2 - Portal Pravaler"
    printLine "    1.3 - Credit Score"
    printLine "    1.4 - API Apartada"
    printLine "    1.5 - API Aprovação"
    printLine "  0 - Sair"
    lineDelimiter
    read -p "| Informe a opção desejada >_ " OPTION
    lineDelimiter
    case $OPTION in
      0) clear
        printPopup "Execução finalizada!"
        exit
      ;;
      1) clear
        printPopup "Instalando TODOS os projetos"
      ;;
      "1.1") clear
        if isValidRepository $BACKOFFICE_LOCAL; then
          printPopup "Configurando o Backoffice"
          setup_backoffice
        else
          printPopup "ERRO: O diretório informado não é válido!"
        fi
      ;;
      "1.2") clear
        if isValidRepository $PORTALPRAVALER_LOCAL; then
          printPopup "Instalando o Portal Pravaler"
          setup_portal_pravaler
        else
          printPopup "ERRO: O diretório informado não é válido!"
        fi
      ;;
      "1.3") clear
        if isValidRepository $CREDITSCORE_LOCAL; then
          printPopup "Instalando o Credit Score"
          setup_credit_score
        else
          printPopup "ERRO: O diretório informado não é válido!"
        fi
      ;;
      "1.4") clear
        if isValidRepository $APIAPARTADA_LOCAL; then
          printPopup "Instalando a API Apartada"
          setup_api_apartada
        else
          printPopup "ERRO: O diretório informado não é válido!"
        fi
      ;;
      "1.5") clear
        if isValidRepository $APIAPROVACAO_LOCAL; then
          printPopup "Instalando a API Aprovação"
          setup_api_aprovacao
        else
          printPopup "ERRO: O diretório informado não é válido!"
        fi
      ;;
      *) clear
        printPopup "Opção inválida!"
      ;;
    esac
    clear
    printPopup "Fim da operação."
    echo -e
  done
}

main
