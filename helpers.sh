#!/bin/bash
#!/usr/bin/env bash

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

# função isNotValidRepository: utiliza a função isValidDirectory e isNotEmptyDirectory para verificar se o primeiro
# parâmetro passado na instancialização da função é um repositório inválido
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

#função isVerifyConfig: Verifica se o Sistema será instalado
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

#função installRepository: Verifica se o repositório existe, se não existir clona o repositório
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

#função composerConfig: Executa o composer install em um diretório passado por parâmetro
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

#função dockerComposeUp: Para os containers e cria os containers novamente
dockerComposeUp() {
    echo -e "\n\tCriando e subindo containers:\n"
    cd $INTEGRACAO_DIR
    docker-compose stop $1
    docker rm $1
    docker-compose build $1
    docker-compose up -d $1

}

#função includeEnv: Inclui um valor no .env
includeEnv() {
    cd $INTEGRACAO_DIR
    DIR_LOCAL=$(echo $2 | sed -e "s/\//\\\\\//g")
    sed -E -i "s/($1=)(.*)/\1$DIR_LOCAL/g" .env
}

#função reloadEnv: Recarrega o .env
reloadEnv() {
    cd $INTEGRACAO_DIR
    . $ENV
}

#função getEnv: Pega um valor da váriavel baseada em outra váriavel
getEnv(){
    VARIABLE=$1
    echo ${!VARIABLE}
}

#função configRepository: Realiza a configuração do repositório baseado nas opções definidas pelo usuário
configRepository() {
    reloadEnv
    NAME_DIR="$2_LOCAL"
    DIR=$(getEnv "$2_LOCAL")
    REPOSITORY=$(getEnv "$2_REPOSITORY")

  if isVerifyConfig "$1"; then
    echo -e "\nComeçando configuração:\n"
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

#função configHost: Configura o arquivo hosts
configHost() {
    HOST_PRINCIPAL=$1
    if [ $TIPO_INSTALACAO == "servidor" ];
    then
        HOST_PRINCIPAL="127.0.0.1"
    fi
    sed -E -i "s/(.*)($2)//g" /etc/hosts
    sed -E -i "s/($HOST_PRINCIPAL)(.*)($2)//g" /etc/hosts
    echo -e "$HOST_PRINCIPAL $2" >> /etc/hosts
    echo -e "\n- Host Configurado."

}

# função lineDelimiter: imprime o delimitador padrão das saidas da aplicação
lineDelimiter() {
  echo "+---------------"
}

# função printHeader: imprime o header padrão das saidas aplicação
printHeader() {
  lineDelimiter
  echo "| ${1}"
  lineDelimiter
}

# função printLine: imprime uma linha na formatação padrão das saidas da aplicação
printLine() {
  echo "| ${1}"
}

# função printPopup: imprime um popup
printPopup() {
  size=${#1}
  i=-3
  while [ $i -le $size ]; do
    echo -n "#"
    i=$((i+1))
  done
  echo -e
  echo "# $1 #"
  j=-3
  while [ $j -le $size ]; do
    echo -n "#"
    j=$((j+1))
  done
  echo -e
}
