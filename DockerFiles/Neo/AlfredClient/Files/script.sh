#!/usr/bin/env bash

#Instalação dos pacotes npm
cd $PROJECT_FOLDER
npm install

#Movendo o arquivo environment.ts(caso exista) para a pasta do projeto
if [ -e "/home/alfred-client/environment.ts" ]
then
    mv /home/alfred-client/environment.ts  src/environments/environment.ts
fi

#Efetua o processo de build da proposta
npm run-script start -- -H 0.0.0.0 --port 80 --disable-host-check

#Retorna um terminal
/bin/bash


