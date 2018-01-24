#!/usr/bin/env bash

INTEGRACAO_DIR=$(pwd)

#Variáveis do ENV
ENV=./.env
# Configuração da Api Apartada
APIAPARTADA_SH=./DockerFiles/ApiApartada/Files/api_apartada.sh
# Configuração da Api Pravaler
APIPRAVALER_SH=./DockerFiles/ApiPravaler/Files/api_pravaler.sh
# Configuração do Backoffice
BACKOFFICE_SH=./DockerFiles/Backoffice/Files/backoffice.sh
# Configuração do CreditScore
CREDITSCORE_SH=./DockerFiles/CreditScore/Files/credit_score.sh
# Configuração do Portal Pravaler
PORTALPRAVALER_SH=./DockerFiles/PortalPravaler/Files/portalpravaler.sh
# Configuração da Nova Proposta - Backend
NOVAPROPOSTA_BACKEND_SH=./DockerFiles/NovaPropostaBackend/Files/nova_proposta_backend.sh
# Configuração do CDN
CDN_SH=./DockerFiles/CDN/Files/cdn.sh
# Configuração do Agendamento de homologação
AGENDAMENTO_SH=$INTEGRACAO_DIR/DockerFiles/Agendamento/Files/agendamento.sh

. $ENV
. $APIPRAVALER_SH
. $APIAPARTADA_SH
. $BACKOFFICE_SH
. $CREDITSCORE_SH
. $PORTALPRAVALER_SH
. $CDN_SH
. $NOVAPROPOSTA_BACKEND_SH
. $AGENDAMENTO_SH


# função isValidDirectory: verifica se o primeiro parâmetro passado na instancialização da função é um diretório válido
isValidDirectory() {
  [ -d $1 ]
}

# função isNotEmptyDirectory: verifica se o primeiro parâmetro passado na instancialização da função não é um diretório vazio
isNotEmptyDirectory() {
  [ "$(ls -A $1)" ]
}

# função isEmptyVariable: verifica se a váriavel existe
isEmptyVariable() {
  [ -z $1 ]
}

# função isValidRepository: utiliza a função isValidDirectory e isNotEmptyDirectory para verificar se o primeiro parâmetro passado na instancialização da função é um repositório válido
isValidRepository() {
  if isValidDirectory $1; then
    if isNotEmptyDirectory $1; then
        if isEmptyVariable $1; then
         false
        else
         true
        fi
    else
      false
    fi
  else
    false
  fi
}

# função isValidRepository: utiliza a função isValidDirectory e isNotEmptyDirectory para verificar se o primeiro parâmetro passado na instancialização da função é um repositório válido
isNotValidRepository() {
  if isValidDirectory $1; then
    if isNotEmptyDirectory $1; then
        if isEmptyVariable $1; then
         true
        else
         false
        fi
    else
      true
    fi
  else
    true
  fi
}

isVerifyConfig() {
    read -p  "Deseja Instalar o Sistema $1 ? (s/n) >_ " verify


    if [ $verify == "s" ];
    then
        true
    elif [ $verify == "n" ];
    then
        false
    else
        echo -e "Opção Inválida"
        false
    fi


}


installRepository() {
    read -p "Repositório Existe? (s/n) >_ " verify

    if [ $verify != "s" ] && [ $verify != "n" ];
    then
        echo -e "\nOpção Inválida" >&2
        return 0
    fi

    read -p  "Informe o caminho do repositório: >_ " repository

    if [ $verify == "s" ];
    then
        echo $repository
    elif [ $verify == "n" ];
    then
        echo -e "\n\tClonando Repositório\n" >&2

        git clone $1 $repository

        if [ $? -eq 0 ]; then
            echo $repository
        else
            false
        fi
    else
        echo -e "Opção Inválida"
        false
    fi
}

composerConfig() {
    echo -e "\n\tRealizando o composer install no diretório $1: \n"
    if [ -f "composer.lock.json" ]
    then
        rm composer.lock.json
    fi
    docker run --rm -v $1:/app kaioidealinvest/composer:php7.1 install

    echo -e "\n\tRealizando o composer update no diretório $1: \n"
    docker run --rm -v $1:/app kaioidealinvest/composer:php7.1 update

    cd $1

    chmod 777 -R vendor/

}

dockerComposeUp() {
    echo -e "\n\tCriando e subindo containers:\n"
    cd $INTEGRACAO_DIR
    docker-compose stop $1
    docker-compose build $1
    docker-compose up -d $1

}
includeEnv() {
    cd $INTEGRACAO_DIR
    DIR_LOCAL=$(echo $2 | sed -e "s/\//\\\\\//g")
    sed -E -i "s/($1=)(.*)/\1$DIR_LOCAL/g" .env
}

reloadEnv() {
    cd $INTEGRACAO_DIR
    . $ENV
}

getEnv(){
    VARIABLE=$1
    echo ${!VARIABLE}
}
configRepository() {
    echo -e "\n\tComeçando configuração:\n"
    reloadEnv
    NAME_DIR="$2_LOCAL"
    DIR=$(getEnv "$2_LOCAL")
    REPOSITORY=$(getEnv "$2_REPOSITORY")

  if isVerifyConfig "$1"; then
    if isNotValidRepository $DIR; then
        DIR=$(installRepository $REPOSITORY)
        if [ $DIR ];
        then
            if isValidRepository $DIR; then
                includeEnv $NAME_DIR $DIR
                $3 $DIR
            else
                echo -e '\nRepositório Inválido.\n'
            fi
        else
            echo -e '\nErro ao instalar Sistema.\n'
        fi
    else
        $3 $DIR
    fi
  fi
}

configHost() {
    echo -e "\n\tConfigurando hosts: \n"
    sed -E -i "s/($1)(.*)//g" /etc/hosts
    sed -E -i "s/(.*)($2)//g" /etc/hosts
    echo -e "$1 $2" >> /etc/hosts
    echo -e "\n- Host Configurado."

}

# Inicializa as funções de configuração dos projetos
main() {

    configRepository "CDN" "CDN" "setup_cdn"

    configRepository "Backoffice" "BACKOFFICE" "setup_backoffice"

    configRepository "Portal Pravaler" "PORTALPRAVALER" "setup_portal_pravaler"

    configRepository "Api Pravaler" "APIPRAVALER" "setup_api_pravaler"

    configRepository "Api Apartada" "APIAPARTADA" "setup_api_apartada"

    configRepository "CreditScore" "CREDITSCORE" "setup_credit_score"

    configRepository "Agendamento de Homologação" "AGENDAMENTO" "setup_agendamento"

}

main
