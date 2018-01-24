#!/usr/bin/env bash

setup_cdn()
{
    echo -e "\n\tnpm install na Raiz do Projeto:\n"
    docker run --rm -v $1:/app kaioidealinvest/node_modules:4 npm install

    echo -e "\n\tbower install bo-messenger:\n"
    docker run --rm -v $1/bo-messenger:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    echo -e "\n\tnpm install bo-messenger:\n"
    docker run --rm -v $1/bo-messenger:/app kaioidealinvest/node_modules:4 \
    npm install

    echo -e "\n\tbower install no investment-fund:\n"
    docker run --rm -v $1/investment-fund:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    echo -e "\n\tnpm install no investment-fund:\n"
    docker run --rm -v $1/investment-fund:/app kaioidealinvest/node_modules:4 \
    npm install

    echo -e "\n\tbower install no negativation:\n"
    docker run --rm -v $1/negativation:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    echo -e "\n\tnpm install no negativation:\n"
    docker run --rm -v $1/negativation:/app kaioidealinvest/node_modules:4 \
    npm install

    echo -e "\n\tbower install no originator-cg:\n"
    docker run --rm -v $1/originator-cg:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    echo -e "\n\tnpm install no originator-cg:\n"
    docker run --rm -v $1/originator-cg:/app kaioidealinvest/node_modules:4 \
    npm install

    echo -e "\n\tbower install no portal:\n"
    docker run --rm -v $1/portal:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install

    echo -e "\n\tbower install no votorantim:\n"
    docker run --rm -v $1/votorantim:/app kaioidealinvest/node_modules:4 \
    bower --allow-root install


    echo -e "\n\tnpm install no votorantim:\n"
    docker run --rm -v $1/votorantim:/app kaioidealinvest/node_modules:4 \
    npm install

    chmod 777 -R $1


}
