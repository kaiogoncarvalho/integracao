#!/bin/bash
#!/usr/bin/env bash

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

# função isEmptyVariable: verifica se a váriavel não existe
isEmptyVariable() {
  [ -z $1 ]
}

# função isNotEmptyVariable: verifica se a váriavel existe
isNotEmptyVariable() {
  if [  -z $1 ];
  then
    return 1
  else
    return 0
  fi
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
     return 1
    else
     return 0
    fi
  else
    return 1
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

    if isEmptyVariable $2;
    then
        PROJECT='sistemas'
    else
        PROJECT=$2
    fi

    docker-compose -p $PROJECT -f $PROJECT.yml stop $1

    deleteContainer $1

    docker-compose -p $PROJECT -f $PROJECT.yml  build  --pull $1
    docker-compose -p $PROJECT -f $PROJECT.yml  up --remove-orphans -d $1



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

    NAME_DIR="$1_LOCAL"
    DIR=$(getEnv "$1_LOCAL")
    REPOSITORY=$(getEnv "$1_REPOSITORY")

    if isNotValidRepository $DIR; then
        registerDatabase
        DIR=$(installRepository $REPOSITORY)
        if [ $DIR ];
        then
            if isValidRepository $DIR; then
                includeEnv $NAME_DIR $DIR
                cd $DIR
                GIT=$(git config core.filemode false)
                $2 $DIR $1
            else
                msgAlert 'Repositório Inválido.'
            fi
        else
            msgAlert 'Erro ao instalar Sistema.'
        fi
    else
        cd $DIR
        GIT=$(git config core.filemode false)
        $2 $DIR $1
        echo -e "\n"
    fi
}

#função getIpContainer: Responsável por pegar o Ip do Container
getIpContainer() {

    network=$2
    if isEmptyVariable $network; then
        network="Pravaler"
    fi

    IP=$(docker inspect --format="{{ .NetworkSettings.Networks.$network.IPAddress}}" $1)
    if [ "$IP" == "<no value>" ]
    then
        msgAlert "Erro ao buscar ip do container $1, possivelmente a Network não foi criada."
    else
        echo $IP
    fi
}

#função configHost: Configura o arquivo hosts
configHost() {
    msgConfig "Configurando Hosts:"
    HOST_PRINCIPAL=$(getIpContainer $1)
    if [ "$TIPO_INSTALACAO" == "servidor" ];
    then
        HOST_PRINCIPAL="127.0.0.1"
    fi
    sed -E -i "s/^([0-9.]*)(\s+)($2)$//g" /etc/hosts
    echo -e "$HOST_PRINCIPAL $2" >> /etc/hosts
    sed -E -i '/^(\s*)$/d' /etc/hosts
    msgConfigItem "Host '$HOST_PRINCIPAL $2' foi configurado."

}

# função lineDelimiter: imprime o delimitador padrão das saidas da aplicação
lineDelimiter() {
  echo -e "+---------------"
}

# função printHeader: imprime o header padrão das saidas aplicação
printHeader() {
  lineDelimiter
  echo -e "| ${1}"
  lineDelimiter
}

# função printLine: imprime uma linha na formatação padrão das saidas da aplicação
printLine() {

   CL=$2

   if isEmptyVariable $CL; then
        CL="branco"
   fi

   ST=$3
   if isEmptyVariable $ST; then
        ST=""
   fi
  msgGeneral "| ${1}" $CL $ST
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
    msgGeneral "\n\t$1\n" 'branco' 'reverso'
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
    echo -e $4 "\033[$ESTILO;$COR$1\033[00;37m"
}

#função configInitialEnv:  Função para copiar o env caso ele não exista
configInitialEnv(){
    msgConfig "Configurando arquivo $(pwd)/.env: "

    if [ -f ".env" ]
    then
        msgConfigItemWarning "Arquivo $(pwd)/.env já existe.\n"
    else
        if isValidFile $1;then
            cp $1 .env
            chmod 777 .env
            msgConfigItemSucess "Arquivo $(pwd)/.env criado.\n"
        else
            msgConfigItemWarning "Arquivo $1 não encontrado.\n"
        fi

    fi


}

#função configEnvIntegracao:  Função para copiar o env do projeto de integração
configEnvIntegracao(){
    msgConfig "Configurando arquivo $(pwd)/.env: "

    if [ -f ".env" ]
    then
        . $ENV_EXAMPLE
        VERSAO_ATUAL=$VERSAO
        . $ENV

        # Verifica se o arquivo .env está na versão certa
        if [ -z $VERSAO ] || [ $VERSAO != $VERSAO_ATUAL ]
        then
            #Atualiza o arquivo .env com os diretórios do antigo arquivo .env

            msgConfigItemWarning "Necessário atualizar arquivo $(pwd)/.env, sua versão está desatualizada.\n"
            cp $1 .env

            SISTEMS=$(getSystems)
            for i in $SISTEMS
            do keepEnv $i
            done

            updateEnv "TIPO_INSTALACAO=" $TIPO_INSTALACAO
            updateEnv "NEO_CONFIG=" $NEO_CONFIG
            updateEnv "NAME_SERVER=" $NAME_SERVER
            updateEnv "INTEGRACAO_DIR=" $INTEGRACAO_DIR

            updateEnv "DATABASE_HOST=" $DATABASE_HOST
            updateEnv "DATABASE_USER=" $DATABASE_USER
            updateEnv "DATABASE_PASSWORD=" $DATABASE_PASSWORD
            updateEnv "DATABASE_PORT=" $DATABASE_PORT
            updateEnv "DATABASE_NAME=" $DATABASE_NAME


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

#função configNeo: instala o config do neo
configNeo(){

    if isNotValidFile $NEO_CONFIG; then

        CAMINHO=$(cd $INTEGRACAO_DIR/.. && pwd)

        read -p "Arquivo config.php já existe? (s/n) >_ " verify

        if [ $verify != "s" ] && [ $verify != "S" ]  && [ $verify != "n" ] && [ $verify != "N" ];
        then
            msgAlert "Opção Inválida" >&2
            return 1
        fi

        if [ $verify == "s" ] || [ $verify == "S" ];
        then
             read -e -p  "Informe o caminho do arquivo config.php do Neo: >_ " -i "$CAMINHO" config
            if isValidFile $config; then
                msgConfigItemSucess "Arquivo $config foi configurado.\n"
                includeEnv "NEO_CONFIG" $config
                return 0
            else
                msgAlert 'Arquivo não encontrado.'
                return 1
            fi
        elif [ $verify == "n" ] || [ $verify == "N" ];
        then
           read -p "Deseja Criar o Arquivo config.php? (s/n) >_ " verify

           if [ $verify != "s" ] && [ $verify != "S" ]  && [ $verify != "n" ] && [ $verify != "N" ];
            then
                msgAlert "Opção Inválida" >&2
                return 1
            fi
            if [ $verify == "s" ] || [ $verify == "S" ];
            then
             read -e -p  "Informe o caminho que vai salvar o arquivo config.php do Neo (Somente o Diretório): >_ " -i "$CAMINHO" dir_config
                if isValidDirectory $dir_config;then
                    config=$(cd $dir_config && pwd)'/config.php'
                    cp $INTEGRACAO_DIR/DockerFiles/Neo/config.php $config

                    msgConfigItemSucess "Arquivo $config foi criado com Sucesso!.\n"
                    includeEnv "NEO_CONFIG" $config
                    return 0
                else
                   msgAlert "Não foi possível salvar o arquivo, diretório não existe"
                   return 1
                fi
             elif [ $verify == "n" ] || [ $verify == "N" ];then
                msgAlert 'Para Instalar os Ambientes Neo é necessário do config.php'
                return 1
             fi

        fi
    else
        msgConfigItemWarning "Arquivo $NEO_CONFIG já existe.\n"
        return 0
    fi

}

#função keepEnv: Mantem os valores entre versões do Env
keepEnv(){

    NAME_DIR="$1_LOCAL"
    NAME_URL="$1_URL"
    DIR=$(getEnv "$NAME_DIR")
    URL=$(getEnv "$NAME_URL")

    updateEnv "$NAME_DIR=" $DIR
    updateEnv "$NAME_URL=" $URL

}

# função printInBar: imprime um popup
printInBar() {

   COLOR=$2

   if isEmptyVariable $COLOR; then
        COLOR="branco"
   fi

   STYLE=$3
   if isEmptyVariable $STYLE; then
        STYLE="negrito"
   fi

  MESSAGE=$1
  MESSAGE_SIZE=${#MESSAGE}
  i=-1
  msgGeneral "+" $COLOR $STYLE '-n'
  while [ $i -le $MESSAGE_SIZE ]; do
    msgGeneral "-" $COLOR $STYLE '-n'
    i=$((i+1))
  done
  msgGeneral "+" $COLOR $STYLE '-n'
  echo -e
  msgGeneral "| ${MESSAGE} |" $COLOR $STYLE
  msgGeneral "+" $COLOR $STYLE '-n'
  j=-1
  while [ $j -le $MESSAGE_SIZE ]; do
    msgGeneral "-" $COLOR $STYLE '-n'
    j=$((j+1))
  done
  msgGeneral "+" $COLOR $STYLE '-n'
  echo -e
}


#função createNetwork: Cria uma rede no docker
createNetwork(){

    network=$1
    if isEmptyVariable $network; then
        network="Pravaler"
    fi

    network_test=$(docker network ls --format "{{ .Name}}" --filter "Name=$network")

    if [ -z $network_test ]
    then
        docker network create --driver=bridge --subnet=172.50.1.0/16 Pravaler
        msgConfigItemSucess "Network $network foi criada.\n"
    else
        msgConfigItemWarning "Network $network já existe.\n"
    fi
}


installServiceNeo(){
    printInBar "Operação Iniciada"
    msgGeneral "\nComeçando configuração do Serviço $1:\n" 'verde' 'negrito'

    if configNeo;
    then
        configRepository "$2" "$3"
        configServer
    fi
    printInBar "Operação Finalizada!"
}

installSystem(){
    printInBar "Operação Iniciada"
    msgGeneral "\nComeçando configuração do Sistema $1:\n" 'verde' 'negrito'

    configRepository "$2" "$3"
    configServer
    printInBar "Operação Finalizada!"
}

installFtp()
{
    msgGeneral "\nComeçando configuração do FTP Risco e Cobrança:\n" 'verde' 'negrito'

    configEnvIntegracao 'example.env'
    createNetwork
    reloadEnv
    setup_ftp_risco_cobranca
}

install(){
    if [ $3 == 'service' ] || [ $4 == 'service' ]; then
        installServiceNeo "$1" "$2" "$3"
    elif [ $3 == 'ftp' ]; then
        installFtp
    else
        installSystem "$1" "$2" "$3"
    fi
}

informEnv(){
    read -e -p  "| Informe $1 >_ " -i "$3" VAR
    updateEnv "$2=" $VAR
    reloadEnv
}

databaseHost(){
    informEnv "Host" "DATABASE_HOST" $DATABASE_HOST
}

databasePort(){
    informEnv "Porta" "DATABASE_PORT" $DATABASE_PORT
}

databaseName(){
    informEnv "Banco" "DATABASE_NAME" $DATABASE_NAME
}

databaseUser(){
    informEnv "Usuário" "DATABASE_USER" $DATABASE_USER
}

databasePassword(){
    read -s -p  "| Informe a Senha >_ " VAR
    updateEnv "DATABASE_PASSWORD=" $VAR
    reloadEnv
}

#Função isValidInstall: Responsável por validar uma instalação
isValidInstall(){
    CONTAINER=$(getEnv "$1_CONTAINER")
    DIR=$(getEnv "$1_LOCAL")

    if isValidRepository $DIR; then
        if verifyContainer $CONTAINER; then
            return 0
        fi
    fi

    return 1
}

#Função verifyContainer: Responsável por verificar se um container existe
verifyContainer(){
    VERIFY=$(docker ps -a -q -f name=$1)


   if isNotEmptyVariable $VERIFY; then
     return 0
    else
     return 1
    fi
}

verifyContainerStarted()
{
    VERIFY=$(docker ps -q -f name=$1$)

   if [ -z $VERIFY ]; then
     return 1
    else
     return 0
    fi
}

#função npmInstall: Executa o NPM install em um diretório passado por parâmetro
npmInstall() {
    msgConfig "Realizando o NPM install no diretório $1: "
    docker run --rm -v $(pwd):/app kaiocarvalhopravaler/node:9 npm install
    chmod 777 -R "$1"
}

#Função bowerInstall: Responsável por instalar o Bower
bowerInstall(){
    if isEmptyVariable $2; then
     DIR='vendor'
    else
     DIR=$2
    fi

    msgConfig "Realizando o Bower install no diretório $1: "
    docker run --rm -v $1:/app kaiocarvalhopravaler/node:9 bower install --allow-root --config.directory=$DIR
    chmod 777 -R "$1"
}

#Função logContainer: Responsável por retornar o log do container
logContainer(){
    msgConfig "Consultando Log do container $1: "
    docker logs $1
}

#Função configServer: Responsável por atualizar o NGINX do Servidor
configServer()
{
    if [ $TIPO_INSTALACAO == "servidor" ];
         then
            echo -e "\nConfigurando Nginx:\n"
            reloadEnv
            setup_nginx
     fi
}

#Função getSystems: Responsável por retornar todos os Sistemas instalados
getSystems(){
    grep -oP '([[:alnum:]_]*)(?=_LOCAL)' "$INTEGRACAO_DIR/.env"
}

#Função php_preg_replace: Função responsável por fazer preg_replace do php em um arquivo
php_preg_replace()
{
    docker run -it --rm -v $3:$3 kaiocarvalhopravaler/php:7.0-cli php preg_replace.php "$1" $2 $3
}

#Função php_preg_replace: Função responsável por fazer preg_replace do php em um arquivo
php_preg_match()
{
    if verifyContainerStarted 'phpcli' && validVolume 'phpcli' $2; then
        docker exec phpcli php preg_match.php "$1" $2 $3
    else
        if verifyContainer 'phpcli'; then
            TESTE=$(docker rm -f phpcli)
        fi
        TESTE=$(docker run -dti --name phpcli -v $2:$2 kaiocarvalhopravaler/php:7.0-cli /bin/bash)

        if verifyContainerStarted 'phpcli'; then
            docker exec phpcli php preg_match.php "$1" $2 $3
        fi

    fi

}

#Função validDatabase: Função Responsável por validar se o Banco de Dados foi totalmente cadastrado
validDatabase(){

    if isNotEmptyVariable $DATABASE_HOST && isNotEmptyVariable $DATABASE_PORT && isNotEmptyVariable $DATABASE_NAME && isNotEmptyVariable $DATABASE_USER && isNotEmptyVariable $DATABASE_PASSWORD; then
        return 0
    else
        return 1
    fi
}

# Função function_exists: Verifica se uma função existe
function_exists() {
  [ `type -t $1`"" == 'function' ]
}

#Função getBranch: Retorna a Branch de um repositório
getBranch()
{
    DIR=$(getEnv "$1_LOCAL")
    cd $DIR
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    echo ${BRANCH}
}

# Função validateNetwork: Valida se a Network é valida
notValidNetwork()
{
    TEST=$(docker inspect --format="{{json .NetworkSettings.Networks}}" $1 | grep -E -i "$2")

    if isEmptyVariable $TEST; then
        return 0
    else
        return 1
    fi

}

validURL()
{
    ALIASES=$(docker inspect --format="{{range .NetworkSettings.Networks}}{{.Aliases}}{{end}}" $1)
    for i in $ALIASES
    do
        if [ $i == $2 ] || [ $i == '['$2 ] || [ $i == $2']' ]; then
            return 0
        fi
    done

    return 1
}

validVolume()
{
   if verifyContainer $1; then
    TEST_VL=$(docker inspect --format="{{ .HostConfig.Binds}}" $1 | grep $2)
        if isNotEmptyVariable $TEST_VL; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

restartContainer()
{
    msgConfig "Reiniciando Container $1"
    if verifyContainer $1; then
        TESTE_CONTAINER=$(docker restart $1)

        if [ $TESTE_CONTAINER == $1 ]; then
            msgConfigItemSucess "Container Reiniciado \n"
        else
            msgAlert " Erro ao reiniciar container"
        fi
    else
         msgAlert "Container não existe"
    fi


}

deleteContainer()
{
    if verifyContainer $1; then
        TESTE_DELETE=$(docker rm -f $1)
    fi
}

updateUrlLote()
{
    msgConfig "Atualizando URL's"
    updateUrl "BACKOFFICE_API" $1

    SISTEMS=$(getSystems)
    for i in $SISTEMS
    do
        updateUrl $i $1
    done


    reloadEnv
}

updateUrl()
{
    PATTERN_URL=$(getEnv $1"_PATTERN_URL")
    NEW_URL=$(echo $PATTERN_URL | sed "s/%CHANGE%/$2/")
    if isNotEmptyVariable $NEW_URL; then
        echo -e $NEW_URL
    fi
    updateEnv $1"_URL=" $NEW_URL
}
validNpm(){
    if validFile "$1/packages.json"; then
        return 0
    fi

    return 1

}

registerDatabase()
{
    if ! validDatabase; then
        read -p "Deseja cadastrar o Banco de Dados? (s/n) >_ " verify

        if [ $verify != "s" ] && [ $verify != "S" ]  && [ $verify != "n" ] && [ $verify != "N" ];
        then
            msgAlert "Opção Inválida" >&2
            return 1
        fi

        if [ $verify == "s" ] || [ $verify == "S" ];
        then
            databaseHost
            databasePort
            databaseName
            databaseUser
            databasePassword
            echo -e "\n"
            return 0
        elif [ $verify == "n" ] || [ $verify == "N" ];
        then
            msgConfigItemWarning "Banco de Dados não Cadastrado"
            return 1
        fi
    fi

}