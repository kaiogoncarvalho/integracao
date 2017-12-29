#!/usr/bin/env bash

DIR=$(grep -E "PORTALPRAVALER_LOCAL=(.*)" ../../../.env | sed -n 's/^PORTALPRAVALER_LOCAL=*//p' ../../../.env)
docker run --rm -v $DIR/:/app kaioidealinvest/composer:php7.1 install --no-scripts
docker run --rm -v $DIR/:/app kaioidealinvest/composer:php7.1 update --no-scripts
docker run --rm -v $DIR/workbench/portal/analytics:/app kaioidealinvest/composer:php7.1 install
docker run --rm -v $DIR/workbench/portal/plugins:/app kaioidealinvest/composer:php7.1 install
docker run --rm -v $DIR/workbench/portal/pravaler-backoffice:/app kaioidealinvest/composer:php7.1 install
docker run --rm -v $DIR/workbench/portal/proposal:/app kaioidealinvest/composer:php7.1 install
docker run --rm -v $DIR/workbench/portal/marketplace:/app kaioidealinvest/composer:php7.1 install
cd $DIR
chmod -R 777 app/storage
