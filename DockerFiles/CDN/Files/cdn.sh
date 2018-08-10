#!/usr/bin/env bash

setup_cdn()
{
    msgConfig "npm install na Raiz do Projeto:"
    docker run --rm -v $1:/app kaiocarvalhopravaler/node:9 npm install --ignore-scripts

    msgConfig "npm install bo-messenger:"
    docker run --rm -v $1/bo-messenger:/app kaiocarvalhopravaler/node:9 \
    npm install --ignore-scripts

    msgConfig "bower install bo-messenger:"
    docker run --rm -v $1/bo-messenger:/app kaiocarvalhopravaler/node:9 \
    bower --allow-root install



    msgConfig "npm install no investment-fund:"
    docker run --rm -v $1/investment-fund:/app kaiocarvalhopravaler/node:9 \
    npm install --ignore-scripts

    msgConfig "bower install no investment-fund:"
    docker run --rm -v $1/investment-fund:/app kaiocarvalhopravaler/node:9 \
    bower --allow-root install



    msgConfig "npm install no negativation:"
    docker run --rm -v $1/negativation:/app kaiocarvalhopravaler/node:9 \
    npm install --ignore-scripts


    msgConfig "bower install no negativation:"
    docker run --rm -v $1/negativation:/app kaiocarvalhopravaler/node:9 \
    bower --allow-root install


    msgConfig "npm install no originator-cg:"
    docker run --rm -v $1/originator-cg:/app kaiocarvalhopravaler/node:9 \
    npm install --ignore-scripts

    msgConfig "bower install no originator-cg:"
    docker run --rm -v $1/originator-cg:/app kaiocarvalhopravaler/node:9 \
    bower --allow-root install


    msgConfig "bower install no portal:"
    docker run --rm -v $1/portal:/app kaiocarvalhopravaler/node:9 \
    bower --allow-root install


    msgConfig "npm install no votorantim:"
    docker run --rm -v $1/votorantim:/app kaiocarvalhopravaler/node:9 \
    npm install --ignore-scripts

    msgConfig "bower install no votorantim:"
    docker run --rm -v $1/votorantim:/app kaiocarvalhopravaler/node:9 \
    bower --allow-root install


    msgConfig "Definindo Permissões:"
    chmod 777 -R $1
    msgConfigItem "Permissões Definidas"

    dockerComposeUp $CDN_CONTAINER

    configHost $CDN_CONTAINER $CDN_URL

}
