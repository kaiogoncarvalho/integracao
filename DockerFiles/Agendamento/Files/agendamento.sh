#!/usr/bin/env bash
set_project_dir()
{
    if ! [ -z $PROJETOS_DIR ]; then
        msgConfigItemWarning " Diretório de Projetos já existe. \n"
        return 1
    fi

    CAMINHO=$(cd $INTEGRACAO_DIR/.. && pwd)

    read -e -p  "Informe o caminho dos Projetos: >_ " -i "$CAMINHO" project_dir

    if ! [ -d "$project_dir" ]; then
        msgAlert "\n Diretório não encontrado."
        set_project_dir
    fi

    project_dir=$(cd $project_dir && pwd)

    regexFile 'PROJETOS_DIR=' $project_dir "$INTEGRACAO_DIR/.env"

    msgConfigItemSucess "\n Diretório de Projetos foi incluído."

    return 1

}

set_squad()
{
    if ! [ -z $APP_SQUAD ]; then
        msgConfigItemWarning "Squad já foi selecionado"
        return 1
    fi

    echo -e
    msgConfig "Incluindo variavel do Squad"
    printLine "1 - Risco e Financeiro"
    printLine "2 - Melhoria Contínua"
    printLine "3 - Clientes"
    printLine "4 - Produtos"
    printLine "5 - Sustentação"
    printLine "6 - UX"
    echo -e

    read -p " | Informe o Squad >_ " option

    case $option in
        1)
            squad="Risco e Financeiro"
        ;;
        2)
            squad="Melhoria Contínua"
        ;;
        3)
            squad="Clientes"
        ;;
        4)
            squad="Produtos"
        ;;
        5)
            squad="Sustentação"
        ;;
        5)
            squad="UX"
        ;;
        *)
            msgAlert "Informe uma opção válida"
            set_squad
        ;;
    esac

    regexFile 'APP_SQUAD=' "'$squad'"

    msgConfigItemSucess "Squad Selecionado"

    return 1

}

set_email()
{
    read -p " \n Informe o E-mail do Squad: " email

    if [ -z $email ]; then
        msgAlert "Informe o E-mail"
        set_email
    fi

    regexFile 'MAIL_USERNAME=' "$email"

    msgConfigItemSucess "E-mail informado"

}

set_id_aplicativo()
{
    read -p "\n Informe o ID do Aplicativo: " id_aplicativo

    if [ -z $id_aplicativo ]; then
        msgAlert "Informe o ID do Aplicativo"
        set_id_aplicativo
    fi

    regexFile "OUTLOOK_CLIENT_ID=" "'$id_aplicativo'"

    msgConfigItemSucess "ID do Aplicativo Informado"
}

set_senha_aplicativo()
{
    read -p "\n Informe a Senha do Aplicativo: " senha_aplicativo

    if [ -z $senha_aplicativo ]; then
        msgAlert "Informe a Senha do Aplicativo"
        set_senha_aplicativo
    fi

    regexFile "OUTLOOK_CLIENT_SECRET=" "'$senha_aplicativo'"

    msgConfigItemSucess "Senha do Aplicativo Informada"

}

set_email_password()
{
    read -s -p "\n Informe a Senha do E-mail: " senha

    if [ -z $senha ]; then
        msgAlert "Informe a Senha"
        set_email_password
    fi

    regexFile 'MAIL_PASSWORD=' "$senha"

    msgConfigItemSucess "Senha do E-mail Informada"
}

seed_systems()
{
    cd $AGENDAMENTO_LOCAL'/database/seeds'
    SISTEMS=$(getSystems)
    for i in $SISTEMS
    do
        CONTAINER=$(getEnv $i"_CONTAINER")
        URL=$(getEnv $i"_URL")
        LOCAL=$(getEnv $i"_LOCAL")
        REPOSITORY=$(getEnv $i"_REPOSITORY")
        FILE="$CONTAINER.php"
        if [ -f ".$FILE" ]; then
             if isValidInstall $i;  then
                cp ".$FILE" $FILE
                chmod 777 $FILE
                sed -E -i "s#(<URL>)#$URL#g" $FILE
                sed -E -i "s#(<LOCAL_DIR>)#$LOCAL#g" $FILE
                sed -E -i "s#(<REPOSITORY>)#$REPOSITORY#g" $FILE
                ativo='false'
                if verifyContainerStarted $CONTAINER; then
                    ativo='true'
                fi
                sed -E -i "s#(ATIVO)#$ativo#g" $FILE
             elif [ -f "$FILE" ]; then
                rm $FILE
             fi

        fi
    done
}

setup_agendamento()
{
    cd $1

    set_project_dir

    composerConfig $1

    configInitialEnv '.env.example'

    . .env

    if [ -z "$APP_SQUAD" ]; then
        set_squad
    fi
    regexFile 'APP_URL=' "$AGENDAMENTO_URL"

    if [ -z "$OUTLOOK_CLIENT_ID" ]; then
        set_id_aplicativo
    fi

    if [ -z "$OUTLOOK_CLIENT_SECRET" ]; then
        set_senha_aplicativo
    fi

    if [ -z $MAIL_USERNAME ]; then
        set_email
    fi

    if [ -z $MAIL_PASSWORD ]; then
        set_email_password
    fi

    if [ -z $PATTERN_HOST ] && ! [ -z $DATABASE_HOST ]; then
        regexFile 'PATTERN_HOST=' "$DATABASE_HOST"
    fi

    if [ -z $PATTERN_DATABASE ] && ! [ -z $DATABASE_NAME ]; then
        regexFile 'PATTERN_DATABASE=' "$DATABASE_NAME"
    fi

    if [ -z $PATTERN_PORT ] && ! [ -z $DATABASE_PORT ]; then
        regexFile 'PATTERN_PORT=' "$DATABASE_PORT"
    fi

    if [ -z $PATTERN_USER ] && ! [ -z $DATABASE_USER ]; then
        regexFile 'PATTERN_USER=' "$DATABASE_USER"
    fi

    if [ -z $PATTERN_PASSWORD ] && ! [ -z $DATABASE_PASSWORD ]; then
        regexFile 'PATTERN_PASSWORD=' "$DATABASE_PASSWORD"
    fi

    cd $1
    if [ -d "xdebug-profile-logs" ]
    then
        msgConfigItemWarning "Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs foi criado."
    fi

     if [ -d '/var/data-mysql' ]
    then
        rm -r /var/data-mysql
    fi
    mkdir /var/data-mysql
    msgConfigItem "Diretório /var/data-mysql foi criado."
    chmod 777 -R $1

   deleteContainer 'mysql'

   dockerComposeUp $AGENDAMENTO_CONTAINER

   seed_systems

   msgConfig "Configurando o Mysql"

   sleep 60

   configHost $AGENDAMENTO_CONTAINER $AGENDAMENTO_URL

   msgConfig "Executando php artisan key:generate: "
   docker exec $AGENDAMENTO_CONTAINER php "artisan" key:generate

   msgConfig "Executando php artisan migrate: "
   docker exec $AGENDAMENTO_CONTAINER php artisan migrate

   msgConfig "Executando php artisan cache:clear: "
   docker exec $AGENDAMENTO_CONTAINER php artisan cache:clear

    msgConfig "Executando composer dump-autolaod"
   docker run --rm -v $AGENDAMENTO_LOCAL:/app composer dump-autoload

   msgConfig "Executando php artisan db:seed: "
   docker exec $AGENDAMENTO_CONTAINER php "$AGENDAMENTO_DOCKER/artisan" db:seed

    msgConfig "Atualizando .env dos Sistemas: "
   docker exec $AGENDAMENTO_CONTAINER curl "http://$AGENDAMENTO_URL/api/env/initial"

   msgConfig "Atualizando eventos: "
   docker exec $AGENDAMENTO_CONTAINER curl "http://$AGENDAMENTO_URL/api/events/sync"



}

