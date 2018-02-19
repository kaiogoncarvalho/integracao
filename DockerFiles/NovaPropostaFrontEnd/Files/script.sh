#!/usr/bin/env bash

# Substitui a diretiva root pelo diretório onde o projeto será publicado
sed -i "s:\$PROJECT_PUBLIC_FOLDER:$(echo $PROJECT_PUBLIC_FOLDER):" /usr/local/${NGINX_VERSION}/conf/apps/proposta.conf

#Instalação dos pacotes npm
cd $PROJECT_FOLDER
npm install

#Renomeando o angular-cli.json, caso o mesmo exista
if [ -e "angular-cli.json~" ]
then
    mv angular-cli.json~ angular-cli.json
fi

# Substitui o nome da pasta de publicação do projeto pela varíavel $PROJECT_PUBLIC_FOLDER
sed -i "/outDir/ s#:.*#: \"$PROJECT_PUBLIC_FOLDER\",#" angular-cli.json

#Movendo o arquivo environment.ts(caso exista) para a pasta do projeto
if [ -e "/home/proposta/environment.ts" ]
then
    mv /home/proposta/environment.ts  src/environments/environment.ts
fi

# Substitui os links do backend da proposta nova e api pravaler
sed -i "s#\$NOVAPROPOSTABACKEND_URL#'$NOVAPROPOSTABACKEND_URL'#" src/environments/environment.ts
sed -i "s#\$APIPRAVALER_URL#'$APIPRAVALER_URL'#" src/environments/environment.ts

#Efetua o processo de build da proposta
npm run ng build

# Inicia o nginx e retorna um terminal
nginx && /bin/bash