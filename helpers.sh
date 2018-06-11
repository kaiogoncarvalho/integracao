#!/bin/bash
#!/usr/bin/env bash


VERSAO_ATUAL='1.7.1'

INTEGRACAO_DIR=$(pwd)

# função isValidDirectory: verifica se o primeiro parâmetro passado na instancialização da função é um diretório válido
isValidDirectory() {
  [ -d $1 ]
}

# função isValidFile: verifica se o primeiro parâmetro passado na instancialização da função é um arquivo válido
isValidFile() {
  [ -f $1 ]
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

# função validFile: utiliza a função isValidDirectory e isNotEmptyDirectory para verificar se o primeiro parâmetro passado na instancialização da função é um repositório válido
validFile() {
  if isValidFile $1; then
    if isEmptyVariable $1; then
     false
    else
     true
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

# função isNotValidRepository: utiliza a função isValidDirectory e isNotEmptyDirectory para verificar se o primeiro
# parâmetro passado na instancialização da função é um repositório inválido
isNotValidFile() {
  if isValidFile $1; then
    if isEmptyVariable $1; then
     true
    else
     false
    fi
  else
    true
  fi
}

#função isVerifyConfig: Verifica se o Sistema será instalado
isVerifyConfig() {
    echo -e -n "\033[01;37mDeseja Instalar o Sistema $1 ? (s/n) >_ \033[00;37m"
    read verify

    if [ $verify == "s" ] || [ $verify == "S" ];
    then
        true
    elif [ $verify == "n" ] || [ $verify == "N" ];
    then
        false
    else
        msgAlert "Opção Inválida"
        false
    fi


}

#função installRepository: Verifica se o repositório existe, se não existir clona o repositório
installRepository() {
    read -p "Já fez o clone do repositório? (s/n) >_ " verify

    if [ $verify != "s" ] && [ $verify != "S" ]  && [ $verify != "n" ] && [ $verify != "N" ];
    then
        msgAlert "Opção Inválida" >&2
        return 0
    fi

    CAMINHO=$(cd $INTEGRACAO_DIR/.. && pwd)

    read -e -p  "Informe o caminho do repositório: >_ " -i "$CAMINHO" repository

    if [ $verify == "s" ] || [ $verify == "S" ];
    then
        echo $repository
    elif [ $verify == "n" ] || [ $verify == "N" ];
    then
        msgConfig "Clonando Repositório" >&2

        git clone $1 $repository

        if [ $? -eq 0 ]; then
            echo $repository
        else
            false
        fi
    else
        msgAlert "Opção Inválida"
        false
    fi
}

#função composerConfig: Executa o composer install em um diretório passado por parâmetro
composerConfig() {
    msgConfig "Realizando o composer install no diretório $1: "
    docker run --rm -v $1:/app composer install --ignore-platform-reqs --no-scripts
    chmod 777 -R "$1/vendor/"
}

#função dockerComposeUp: Para os containers e cria os containers novamente
dockerComposeUp() {
    msgConfig "Criando e subindo containers:"
    cd $INTEGRACAO_DIR

    if [ $2 == "neo" ];
    then
        docker-compose -p neo -f neo.yml stop $1
        docker rm -f $1
        docker-compose -p neo -f neo.yml  build --pull $1
        docker-compose -p neo -f neo.yml  up -d $1
    else
        docker-compose stop $1
        docker rm -f $1
        docker-compose build --pull $1
        docker-compose up -d $1
    fi


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
    msgGeneral "\nComeçando configuração:\n" 'verde' 'negrito'
    if isNotValidRepository $DIR; then
        DIR=$(installRepository $REPOSITORY)
        if [ $DIR ];
        then
            if isValidRepository $DIR; then
                includeEnv $NAME_DIR $DIR
                $3 $DIR
                cd $DIR
                git config core.filemode false
            else
                msgAlert 'Repositório Inválido.'
            fi
        else
            msgAlert 'Erro ao instalar Sistema.'
        fi
    else
        $3 $DIR
        echo -e "\n"
    fi
  fi
}

#função configHost: Configura o arquivo hosts
configHost() {
    msgConfig "Configurando Hosts:"
    HOST_PRINCIPAL=$1
    if [ $TIPO_INSTALACAO == "servidor" ];
    then
        HOST_PRINCIPAL="127.0.0.1"
    fi
    sed -E -i "s/(.*)($2)//g" /etc/hosts
    sed -E -i "s/($HOST_PRINCIPAL)(.*)($2)//g" /etc/hosts
    echo -e "$HOST_PRINCIPAL $2" >> /etc/hosts
    msgConfigItem "Host '$HOST_PRINCIPAL $2' foi configurado."

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

# função regexFile: Altera um arquivo com regex
regexFile(){
    FILE=$3
    if isEmptyVariable $FILE; then
        FILE=".env"
    fi
    sed -E -i "s#($1)(.*)#\1$2#g" $FILE
}

#função msgAlert: Retonar um texto no formato de alerta
msgAlert(){
    msgGeneral "\n$1\n" 'vermelho' 'reverso'
}

#função msgConfig: Retorna texto no formato configuração
msgConfig(){
    msgGeneral "\n\t$1" 'branco' 'reverso'
}

#função msgConfigItem:  Retorna texto no formato item configuração
msgConfigItem(){
    echo -e "\n- $1"
}

#função msgConfigItemWarning:  Retorna texto no formato item configuração
msgConfigItemWarning(){
     msgGeneral "\n- $1" 'amarelo'
}

#função msgConfigItemWarning:  Retorna texto no formato item configuração
msgConfigItemSucess(){
     msgGeneral "\n- $1" 'verde'
}

#função msgGeneral:  Função generalizada para escolha de cor e estilo
msgGeneral(){
    COR='37m'
    ESTILO=00
    case $2 in
        'preto')
            COR='30m'
         ;;
         'vermelho')
            COR='31m'
         ;;
         'verde')
            COR='32m'
         ;;
         'amarelo')
            COR='33m'
         ;;
         'rosa')
            COR='35m'
         ;;
         'ciano')
            COR='36m'
         ;;
         'branco')
            COR='37m'
    esac
    case $3 in
        'negrito')
            ESTILO=01
         ;;
         'sublinhado')
            ESTILO=04
         ;;
         'reverso')
            ESTILO=07
         ;;
    esac
    echo -e "\033[$ESTILO;$COR$1\033[00;37m"
}

#função configInitialEnv:  Função para copiar o env caso ele não exista
configInitialEnv(){
    msgConfig "Configurando arquivo $(pwd)/.env: "

    if [ -f ".env" ]
    then
        msgConfigItemWarning "Arquivo $(pwd)/.env já existe.\n"
    else
        cp $1 .env
        msgConfigItem "Arquivo $(pwd)/.env criado.\n"
    fi

    chmod 777 .env
}

#função configEnvIntegracao:  Função para copiar o env do projeto de integração
configEnvIntegracao(){
    msgConfig "Configurando arquivo $(pwd)/.env: "

    if [ -f ".env" ]
    then
        . $ENV
        # Verifica se o arquivo .env está na versão certa
        if [ -z $VERSAO ] || [ $VERSAO != $VERSAO_ATUAL ]
        then
            #Atualiza o arquivo .env com os diretórios do antigo arquivo .env

            msgConfigItemWarning "Necessário atualizar arquivo $(pwd)/.env, sua versão está desatualizada.\n"
            cp $1 .env

            updateEnv "BACKOFFICE_LOCAL=" $BACKOFFICE_LOCAL
            updateEnv "PORTALPRAVALER_LOCAL=" $PORTALPRAVALER_LOCAL
            updateEnv "APIPRAVALER_LOCAL=" $APIPRAVALER_LOCAL
            updateEnv "APIAPARTADA_LOCAL=" $APIAPARTADA_LOCAL
            updateEnv "CREDITSCORE_LOCAL=" $CREDITSCORE_LOCAL
            updateEnv "AGENDAMENTO_LOCAL=" $AGENDAMENTO_LOCAL

            updateEnv "CDN_LOCAL=" $CDN_LOCAL

            updateEnv "NOVAPROPOSTA_BACKEND_LOCAL=" $NOVAPROPOSTA_BACKEND_LOCAL
            updateEnv "NOVAPROPOSTA_FRONTEND_LOCAL=" $NOVAPROPOSTA_FRONTEND_LOCAL

            updateEnv "NEO_NEGOTIATION_LOCAL=" $NEO_NEGOTIATION_LOCAL
            updateEnv "NEO_PROPOSAL_LOCAL=" $NEO_PROPOSAL_LOCAL
            updateEnv "NEO_INTEGRATION_LOCAL=" $NEO_INTEGRATION_LOCAL
            
            updateEnv "BACKOFFICE_URL=" $BACKOFFICE_URL
            updateEnv "PORTALPRAVALER_URL=" $PORTALPRAVALER_URL
            updateEnv "APIPRAVALER_URL=" $APIPRAVALER_URL
            updateEnv "APIAPARTADA_URL=" $APIAPARTADA_URL
            updateEnv "CREDITSCORE_URL=" $CREDITSCORE_URL
            updateEnv "AGENDAMENTO_URL=" $AGENDAMENTO_URL
            updateEnv "CDN_URL=" $CDN_URL

            updateEnv "NOVAPROPOSTA_BACKEND_URL=" $NOVAPROPOSTA_BACKEND_URL
            updateEnv "NOVAPROPOSTA_FRONTEND_URL=" $NOVAPROPOSTA_FRONTEND_URL

            updateEnv "NEO_NEGOTIATION_URL=" $NEO_NEGOTIATION_URL
            updateEnv "NEO_PROPOSAL_URL=" $NEO_PROPOSAL_URL
            updateEnv "NEO_INTEGRATION_URL=" $NEO_INTEGRATION_URL


            updateEnv "TIPO_INSTALACAO=" $TIPO_INSTALACAO
            updateEnv "NEO_CONFIG=" $NEO_CONFIG

            . $ENV
            msgConfigItemSucess "Arquivo $(pwd)/.env foi atualizado.\n"

        else
            msgConfigItemWarning "Arquivo $(pwd)/.env já existe.\n"
        fi
    else
        cp $1 .env
        msgConfigItemSucess  "Arquivo $(pwd)/.env criado.\n"
    fi

    chmod 777 .env
}

#função updateEnv: Atualiza o ENV se a variavel existir
updateEnv(){
    if [[  $2 ]]
    then
        regexFile $1 $2
    fi
}

#função testSystem: Abre o navegador com o novo sistema
testSystem(){
   google-chrome $1 --no-sandbox
}

#função configNeo: instala o config do neo
configNeo(){

    if isNotValidFile $NEO_CONFIG; then

        CAMINHO=$(cd $INTEGRACAO_DIR/.. && pwd)

        read -e -p  "Informe o caminho do arquivo config.php do Neo: >_ " -i "$CAMINHO" config
        if isValidFile $config; then
            msgConfigItemSucess "Arquivo $config foi configurado.\n"
            includeEnv "NEO_CONFIG" $config
        else
            msgAlert 'Arquivo não encontrado.'
            false
        fi
    else
        msgConfigItemWarning "Arquivo $NEO_CONFIG já existe.\n"
        true
    fi

}