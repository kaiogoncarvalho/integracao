#!/usr/bin/env bash

AGENDAMENTO_DIR=$(grep -E "AGENDAMENTO_LOCAL=(.*)" ../../../.env | sed -n 's/^AGENDAMENTO_LOCAL=*//p' ../../../.env)
BACKOFFICE_DIR=$(grep -E "BACKOFFICE_LOCAL=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_LOCAL=*//p' ../../../.env)
docker run --rm -v $BACKOFFICE_DIR/:/app kaioidealinvest/composer:php7.1 install
cd $AGENDAMENTO_DIR
cp .env.example .env
cp $BACKOFFICE_DIR/.env $AGENDAMENTO_DIR/helpers/backoffice.env.bkp
chmod 777 -R $AGENDAMENTO_DIR

