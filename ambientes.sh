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
# Configuração do CDN
CDN_SH=./DockerFiles/CDN/Files/cdn.sh


. $ENV
. $APIAPROVACAO_SH
. $APIAPARTADA_SH
. $BACKOFFICE_SH
. $CREDITSCORE_SH
. $PORTALPRAVALER_SH
. $CDN_SH


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

# Inicializa as funções de configuração dos projetos
main() {

  if isValidRepository $APIAPROVACAO_LOCAL; then
    echo "\nComeçando configuração da Api de Aprovação:\n"
    setup_api_aprovacao
  else
    echo "\nRepositório da Api de Aprovação não foi encontrado.\n"
  fi

  if isValidRepository $APIAPARTADA_LOCAL; then
    echo "\nComeçando configuração da Api Apartada:\n"
    setup_api_apartada
  else
    echo "\nRepositório da Api Apartada não foi encontrado.\n"
  fi

  if isValidRepository $BACKOFFICE_LOCAL; then
    echo "\nComeçando configuração do Backoffice:\n"
    setup_backoffice
  else
    echo "\nRepositório do Backoffice não foi encontrado.\n"
  fi

  if isValidRepository $CDN_LOCAL; then
    echo "\nComeçando configuração do CDN:\n"
    setup_credit_score
  else
    echo "\nRepositório do CDN não foi encontrado.\n"
  fi

  if isValidRepository $CREDITSCORE_LOCAL; then
    echo "\nComeçando configuração do CreditScore:\n"
    setup_credit_score
  else
    echo "\nRepositório do CreditScore não foi encontrado.\n"
  fi

  if isValidRepository $PORTALPRAVALER_LOCAL; then
    echo "\nComeçando configuração do Portal Pravaler:\n"
    setup_portal_pravaler
  else
    echo "\nRepositório do Portal Pravaler não foi encontrado.\n"
  fi

}

main
