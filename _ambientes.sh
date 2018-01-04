#!/bin/bash
#!/usr/bin/env bash

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


# função isValidDirectory: verifica se o primeiro parâmetro passado na instancialização da função é um diretório válido
isValidDirectory() {
  [ -d $1 ]
}

# função isNotEmptyDirectory: verifica se o primeiro parâmetro passado na instancialização da função não é um diretório vazio
isNotEmptyDirectory() {
  [ "$(ls -A $1)" ]
}

# função isValidRepository: utiliza a função isValidDirectory e isNotEmptyDirectory para verificar se o primeiro parâmetro passado na instancialização da função é um repositório válido
isValidRepository() {
  if isValidDirectory $1; then
    if isNotEmptyDirectory $1; then
      true
    else
      false
    fi
  else
    false
  fi
}

printHeader() {
  echo "+---------------"
  echo "| ${1}"
  echo "+---------------"
}

printLine() {
  echo "| ${1}"
}

printPopup() {
  size=${#1}
  echo ${size}
}

readNext() {
  echo "+---------------"
  read -p "| ${1} >_ " USER_INPUT
  echo "+---------------"
  return USER_INPUT
}

menu() {
  printPopup 81221
  exit
  while true;
  do
    printHeader "CONFIGURAÇÃO DE PROJETOS - IDEAL INVEST"
    printLine "Informe a opção desejada:"
    printLine "  1 - Instalar ambientes"
    printLine "    1.1 - Backoffice"
    printLine "    1.2 - Portal Pravaler"
    printLine "    1.3 - Credit Score"
    printLine "    1.4 - API Apartada"
    printLine "    1.5 - API Aprovação"
    printLine "    1.6 - MongoDB"
    printLine "    1.7 - Nginx"
    printLine "  0 - Sair"
    # OPTION=readNext "Informe a opção desejada"
    echo -e
    case $OPTION in
      0) clear
        echo "+---------------"
        echo "| Execução finalizada!"
        echo "+---------------"
        exit
      ;;
      1) clear
        echo "+---------------"
        echo "| Instalando TODOS projetos"
        echo "+---------------"
      ;;
      "1.1") clear
        echo "+---------------"
        echo "| Instalando Backoffice"
        echo "+---------------"
      ;;
      "1.2") clear
        echo "+---------------"
        echo "| Instalando Portal Pravaler"
        echo "+---------------"
      ;;
      "1.3") clear
        echo "+---------------"
        echo "| Instalando Credit Score"
        echo "+---------------"
      ;;
      "1.4") clear
        echo "+---------------"
        echo "| Instalando API Apartada"
        echo "+---------------"
      ;;
      "1.5") clear
        echo "+---------------"
        echo "| Instalando API Aprovação"
        echo "+---------------"
      ;;
      "1.6") clear
        echo "+---------------"
        echo "| Instalando MongoDB"
        echo "+---------------"
      ;;
      "1.7") clear
        echo "+---------------"
        echo "| Instalando Nginx"
        echo "+---------------"
      ;;
      *) clear
        echo "+---------------"
        echo "| Opção inválida!"
        echo "+---------------"
      ;;
    esac
    clear
    echo "+---------------"
    echo "| Fim da operação"
    echo "+---------------"
    echo -e
  done
}

# Inicializa as funções de configuração dos projetos
main() {
  menu
  # if isValidRepository $APIAPROVACAO_LOCAL; then
  #   echo "\nComeçando configuração da Api de Aprovação:\n"
  #   setup_api_aprovacao
  # else
  #   echo "\nRepositório da Api de Aprovação não foi encontrado.\n"
  # fi
  #
  # if isValidRepository $APIAPARTADA_LOCAL; then
  #   echo "\nComeçando configuração da Api Apartada:\n"
  #   setup_api_apartada
  # else
  #   echo "\nRepositório da Api Apartada não foi encontrado.\n"
  # fi
  #
  # if isValidRepository $BACKOFFICE_LOCAL; then
  #   echo "\nComeçando configuração do Backoffice:\n"
  #   setup_backoffice
  # else
  #   echo "\nRepositório do Backoffice não foi encontrado.\n"
  # fi
  #
  # if isValidRepository $CREDITSCORE_LOCAL; then
  #   echo "\nComeçando configuração do CreditScore:\n"
  #   setup_credit_score
  # else
  #   echo "\nRepositório do CreditScore não foi encontrado.\n"
  # fi
  #
  # if isValidRepository $PORTALPRAVALER_LOCAL; then
  #   echo "\nComeçando configuração do Portal Pravaler:\n"
  #   setup_portal_pravaler
  # else
  #   echo "\nRepositório do Portal Pravaler não foi encontrado.\n"
  # fi

}

main
