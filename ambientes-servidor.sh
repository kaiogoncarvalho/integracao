#!/usr/bin/env bash

AMBIENTES=./ambientes.sh

. $AMBIENTES

# Configuração do Agendamento
AGENDAMENTO_SH=$INTEGRACAO_DIR/DockerFiles/Agendamento/Files/agendamento.sh
# Configuração do Nginx
NGINX_SH=$INTEGRACAO_DIR/DockerFiles/Nginx/Files/nginx.sh

. $AGENDAMENTO_SH
. $NGINX_SH

main_servidor()
{

  if isValidRepository $AGENDAMENTO_LOCAL; then
    echo "\nComeçando configuração do Agendamento:\n"
    setup_agendamento
  else
    echo "\nRepositório do Agendamento não foi encontrado.\n"
  fi

  echo "\nComeçando configuração do NGINX:\n"
  setup_nginx

}

main_servidor