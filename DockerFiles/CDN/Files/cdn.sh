#!/usr/bin/env bash

setup_cdn()
{
    msgConfig "npm install na Raiz do Projeto:"
    docker run --rm -v $1:/app kaioidealinvest/node_modules:4 npm install

    msgConfig "bower install bo-messenger:"
    docker run --rm -v $1/bo-messenger:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    msgConfig "npm install bo-messenger:"
    docker run --rm -v $1/bo-messenger:/app kaioidealinvest/node_modules:4 \
    npm install

    msgConfig "bower install no investment-fund:"
    docker run --rm -v $1/investment-fund:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    msgConfig "npm install no investment-fund:"
    docker run --rm -v $1/investment-fund:/app kaioidealinvest/node_modules:4 \
    npm install

    msgConfig "bower install no negativation:"
    docker run --rm -v $1/negativation:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    msgConfig "npm install no negativation:"
    docker run --rm -v $1/negativation:/app kaioidealinvest/node_modules:4 \
    npm install

    msgConfig "bower install no originator-cg:"
    docker run --rm -v $1/originator-cg:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    msgConfig "npm install no originator-cg:"
    docker run --rm -v $1/originator-cg:/app kaioidealinvest/node_modules:4 \
    npm install

    msgConfig "bower install no portal:"
    docker run --rm -v $1/portal:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    msgConfig "bower install no votorantim:"
    docker run --rm -v $1/votorantim:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install


    msgConfig "npm install no votorantim:"
    docker run --rm -v $1/votorantim:/app kaioidealinvest/node_modules:4 \
    npm install

    chmod 777 -R $1


}
