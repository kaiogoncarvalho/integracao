#!/usr/bin/env bash

DIR=$(grep -E "CREDITSCORE_LOCAL=(.*)" ../../../.env | sed -n 's/^CREDITSCORE_LOCAL=*//p' ../../../.env)
DB=$(grep -E "DATABASE=(.*)" ../../../.env | sed -n 's/^DATABASE=*//p' ../../../.env)
HOSTAPI=$(grep -E "BACKOFFICE_API_URL=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_API_URL=*//p' ../../../.env)


docker run --rm -v $DIR/:/app kaioidealinvest/composer:php7.1 install
cd $DIR
cp .env-example .env
sed -i -E "s/db.bo.host=(.*)/db.bo.host=$DB/g" .env
sed -i -E "s/bo.api.host=(.*)/bo.api.host=$HOSTAPI\/portal\/pravaler_v2/g" .env