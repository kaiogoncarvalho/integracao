#!/usr/bin/env bash

setup_portal_pravaler()
{
    docker run --rm -v $PORTALPRAVALER_LOCAL/:/app kaioidealinvest/composer:php7.1 install --no-scripts
    docker run --rm -v $PORTALPRAVALER_LOCAL/:/app kaioidealinvest/composer:php7.1 update --no-scripts
    docker run --rm -v $PORTALPRAVALER_LOCAL/workbench/portal/analytics:/app kaioidealinvest/composer:php7.1 install
    docker run --rm -v $PORTALPRAVALER_LOCAL/workbench/portal/plugins:/app kaioidealinvest/composer:php7.1 install
    docker run --rm -v $PORTALPRAVALER_LOCAL/workbench/portal/pravaler-backoffice:/app kaioidealinvest/composer:php7.1 install
    docker run --rm -v $PORTALPRAVALER_LOCAL/workbench/portal/proposal:/app kaioidealinvest/composer:php7.1 install
    docker run --rm -v $PORTALPRAVALER_LOCAL/workbench/portal/marketplace:/app kaioidealinvest/composer:php7.1 install
    cd $PORTALPRAVALER_LOCAL
    chmod -R 777 app/storage
    chmod -R 777 vendor
    chmod 777 composer.lock
}

