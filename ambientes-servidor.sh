#!/usr/bin/env bash

AMBIENTES=./ambientes.sh
# Configuração do Agendamento
AGENDAMENTO_SH=$INTEGRACAO/DockerFiles/Agendamento/Files/agendamento.sh
# Configuração do Nginx
NGINX_SH=$INTEGRACAO/DockerFiles/Nginx/Files/nginx.sh

. $AMBIENTES
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