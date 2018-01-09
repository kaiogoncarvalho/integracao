#!/usr/bin/env bash

setup_cdn()
{
    echo -e "npm install na Raiz do Projeto:\n"
    docker run --rm -v $CDN_LOCAL:/app kaioidealinvest/node_modules:4 npm install

    echo -e "npm install bo-messenger:\n"
    docker run --rm -v $CDN_LOCAL/bo-messenger:/app kaioidealinvest/node_modules:4 \
    npm install

    echo -e "bower install bo-messenger:\n"
    docker run --rm -v $CDN_LOCAL/bo-messenger:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    echo -e "npm install no investment-fund:\n"
    docker run --rm -v $CDN_LOCAL/investment-fund:/app kaioidealinvest/node_modules:4 \
    npm install

    echo -e "bower install no investment-fund:\n"
    docker run --rm -v $CDN_LOCAL/investment-fund:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    echo -e "npm install no negativation:\n"
    docker run --rm -v $CDN_LOCAL/negativation:/app kaioidealinvest/node_modules:4 \
    npm install

    echo -e "bower install no negativation:\n"
    docker run --rm -v $CDN_LOCAL/negativation:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    echo -e "npm install no originator-cg:\n"
    docker run --rm -v $CDN_LOCAL/originator-cg:/app kaioidealinvest/node_modules:4 \
    npm install

    echo -e "bower install no originator-cg:\n"
    docker run --rm -v $CDN_LOCAL/originator-cg:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    echo -e "npm install no portal:\n"
    docker run --rm -v $CDN_LOCAL/portal:/app kaioidealinvest/node_modules:4 \
    npm install

    echo -e "bower install no portal:\n"
    docker run --rm -v $CDN_LOCAL/portal:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    echo -e "npm install no votorantim:\n"
    docker run --rm -v $CDN_LOCAL/votorantim:/app kaioidealinvest/node_modules:4 \
    npm install

    echo -e "bower install no votorantim:\n"
    docker run --rm -v $CDN_LOCAL/votorantim:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    chmod 777 -R $CDN_LOCAL


}
