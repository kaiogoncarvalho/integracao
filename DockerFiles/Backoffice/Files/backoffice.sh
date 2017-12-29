#!/usr/bin/env bash

DIR_DOCKER=$(grep -E "BACKOFFICE_DOCKER=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_DOCKER=*//p' ../../../.env)
HOST=$(grep -E "BACKOFFICE_URL=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_URL=*//p' ../../../.env)
HOSTAPI=$(grep -E "BACKOFFICE_API_URL=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_API_URL=*//p' ../../../.env)
HOSTPORTAL=$(grep -E "PORTALPRAVALER_URL=(.*)" ../../../.env | sed -n 's/^PORTALPRAVALER_URL=*//p' ../../../.env)
DIR=$(grep -E "BACKOFFICE_LOCAL=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_LOCAL=*//p' ../../../.env)
DB=$(grep -E "DATABASE=(.*)" ../../../.env | sed -n 's/^DATABASE=*//p' ../../../.env)
APIAPROVACAO=$(grep -E "APIAPROVACAO_URL=(.*)" ../../../.env | sed -n 's/^APIAPROVACAO_URL=*//p' ../../../.env)
docker run --rm -v $DIR/:/app kaioidealinvest/composer:php7.1 install
cd $DIR
cp sample.env .env
OLD_DB=$(grep -E "db.default.host=(.*)" .env | sed -n 's/^db.default.host=*//p' .env)
sed -i -e "s/$OLD_DB/$DB/g" .env
sed -i -E "s/api.aprovacaoIes.path=(.*)/api.aprovacaoIes.path=$APIAPROVACAO\\/v1.1/g" .env
OLD_HOST=$(grep -E "backoffice.domain=(.*)" .env | sed -n 's/^backoffice.domain=*//p' .env)
sed -i -e "s/$OLD_HOST/$HOST/g" .env
sed -i -E "s/api.url=(.*)/api.url=$HOSTAPI/g" .env
OLD_HOSTPORTAL=$(grep -E "portal.domain=(.*)" .env | sed -n 's/^portal.domain=*//p' .env)
DIR_DOCKER=$(echo $DIR_DOCKER | sed -e "s/\//\\\\\//g")
echo $DIR_DOCKER
sed -i -E "s/\/home\/httpd\/html\/idealinvest.com.br\//$DIR_DOCKER\//g" .env
cd html/portal/pravaler/
mkdir log
cd backoffice/
mkdir cnab
cd cnab
mkdir bancos
cd bancos
mkdir db
cd $DIR
chmod 777 -R html/
