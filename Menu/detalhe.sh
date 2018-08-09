#!/usr/bin/env bash

detalhe(){
     while true;
    do
        reloadEnv
        CONTAINER=$(getEnv "$2_CONTAINER")
        URL=$(getEnv "$2_URL")
        IP=$(getEnv "$2_IP")
        DIRECTORY=$(getEnv "$2_LOCAL")
        DIR_DOCKER=$(getEnv "$2_DOCKER")
        STATUS=''
        SEE_ENV=0
        ALTER_ENV=0
        SEE_ENV_NEO=0
        ALTER_ENV_NEO=0
        UPDATE_DATABASE=0
        SEE_PASS=0
        NPM_UPDATE=0
        ENTERC=0
        STOPC=0

        if [ $3 == 'service' ] || [ $4 == 'service' ] 2> /dev/null; then
            FUNCTION_DATABASE='display_database_neo'
            FUNCTION_CHANGE_DATABASE='database_neo'
        else
            FUNCTION_DATABASE='display_database_'$CONTAINER
            FUNCTION_CHANGE_DATABASE='database_'$CONTAINER
        fi

        printInBar "Ambientes Pravaler" "ciano"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        echo -e
        printInBar "Sistema $1" "amarelo"
         echo -e
        echo -e "\033[07;37mInformações\n\033[00;37m"

        if isValidInstall $2; then

            if notValidNetwork $CONTAINER 'Pravaler'; then
                STATUS=$STATUS"\033[07;31m- Rede do Container Diferente (necessário reinstalar o Sistema)\033[00;31m\n\n"
            fi

            BRANCH=$(getBranch $2)

            if verifyContainerStarted $CONTAINER; then
                COR_CONTAINER='32m'
            else
                COR_CONTAINER='31m'
                STATUS=$STATUS"\033[07;31m- Container parado (necessário reiniciar o container)\033[00;31m\n\n"
            fi

            echo -e "\033[01;37mContainer: \033[00;37m\033[01;$COR_CONTAINER$CONTAINER\033[00;37m"

            if isValidRepository $DIRECTORY; then
                echo -e "\033[01;37mBranch: \033[00;37m\033[01;32m$BRANCH\033[00;37m"
            fi



            if validURL $CONTAINER $URL; then
                COR_URL='32m'
            else
                COR_URL='31m'
                STATUS=$STATUS"\033[07;31m- URL do Container Diferente, URLS válidas: $ALIASES (necessário reinstalar o Sistema)\033[00;31m\n\n"
            fi

            echo -e "\033[01;37mURL: \033[00;37m\033[01;$COR_URL$URL \033[00;37m"
            echo -e "\033[01;37mIP: \033[00;37m\033[01;32m$IP\033[00;37m"

            if function_exists $FUNCTION_DATABASE; then
                $FUNCTION_DATABASE
                deleteContainer 'phpcli'
                echo -e
                echo -e "\033[07;37mBanco de Dados Backoffice\n\033[00;37m"



                COR_HOST='31m'
                COR_PORT='31m'
                COR_NAME='31m'
                COR_USER='31m'
                COR_PASSWORD='31m'
                if validDatabase; then


                    if [ $SYSTEM_DB_HOST == $DATABASE_HOST ] 2> /dev/null; then
                        COR_HOST='32m'
                    else
                        STATUS=$STATUS"\033[07;31m- Host do Banco de Dados Diferente, Host: $DATABASE_HOST (necessário atualizar o banco de dados)\033[00;31m\n\n"
                    fi

                    if [ $SYSTEM_DB_PORT == $DATABASE_PORT ] 2> /dev/null; then
                        COR_PORT='32m'
                    else
                        STATUS=$STATUS"\033[07;31m- Porta do Banco de Dados Diferente, Porta: $DATABASE_PORT (necessário atualizar o banco de dados)\033[00;31m\n\n"
                    fi

                    if [ $SYSTEM_DB_NAME == $DATABASE_NAME ] 2> /dev/null; then
                        COR_NAME='32m'
                    else
                        STATUS=$STATUS"\033[07;31m- Nome do Banco de Dados Diferente, Nome: $DATABASE_NAME (necessário atualizar o banco de dados)\033[00;31m\n\n"
                    fi

                    if [ $SYSTEM_DB_USER == $DATABASE_USER ] 2> /dev/null; then
                        COR_USER='32m'
                    else
                        STATUS=$STATUS"\033[07;31m- Usuário do Banco de Dados Diferente, Usuário: $DATABASE_USER (necessário atualizar o banco de dados)\033[00;31m\n\n"
                    fi

                    if [ $SYSTEM_DB_PASSWORD == $DATABASE_PASSWORD ] 2> /dev/null; then
                        COR_PASSWORD='32m'
                    else
                        STATUS=$STATUS"\033[07;31m- Senha do Banco de Dados Diferente (necessário atualizar o banco de dados)\033[00;31m\n\n"
                    fi
                fi

                echo -e "\033[01;37mHost: \033[00;37m\033[01;$COR_HOST$SYSTEM_DB_HOST\033[00;37m"
                echo -e "\033[01;37mPorta: \033[00;37m\033[01;$COR_PORT$SYSTEM_DB_PORT \033[00;37m"
                echo -e "\033[01;37mBanco: \033[00;37m\033[01;$COR_NAME$SYSTEM_DB_NAME\033[00;37m"
                echo -e "\033[01;37mUsuário: \033[00;37m\033[01;$COR_USER$SYSTEM_DB_USER\033[00;37m"
            fi

            if ! [ -d $DIRECTORY'/vendor' ] && validFile $DIRECTORY'/composer.json'; then
                STATUS=$STATUS"\033[07;31m- Composer não instalado (necessário reinstalar sistema)\033[00;31m\n\n"
            fi
        else
            echo -e "\033[01;37mURL: \033[00;37m\033[01;31m$URL \033[00;37m"
            echo -e "\033[01;37mIP: \033[00;37m\033[01;31m$IP\033[00;37m"
            STATUS="\033[07;31m- Ambiente não Instalado\033[00;31m\n"
        fi

        echo -e
        echo -e "\033[07;37mStatus\n\033[00;37m"
        if isEmptyVariable $STATUS;then
            STATUS="\033[07;32m- Ambiente Instalado\033[00;31m\n"
        fi

        echo -e $STATUS

        printInBar "Menu" "verde"
        printLine "1 - Instalar/Reinstalar"
        printLine "2 - Alterar URL"
        if isValidInstall $2; then
            printLine "3 - Reiniciar Container"
            printLine "4 - Consultar Log"
            printLine "5 - Acessar Pasta do Projeto"

            NEXT=6

            if verifyContainerStarted $CONTAINER;then
                ENTERC=$NEXT
                printLine "$ENTERC - Entrar no Container"
                NEXT=$(echo $(($NEXT+1)))
                STOPC=$NEXT
                NEXT=$(echo $(($NEXT+1)))
                printLine "$STOPC - Parar Container"
            fi




            if validFile $DIRECTORY'/.env'; then
                SEE_ENV=$NEXT
                printLine "$SEE_ENV - Ver Arquivo de configuração .env"
                NEXT=$(echo $(($NEXT+1)))
                ALTER_ENV=$NEXT
                printLine "$ALTER_ENV - Alterar Arquivo de configuração .env"
                NEXT=$(echo $(($NEXT+1)))
            fi

            if validFile $DIRECTORY'/config.php'; then
                SEE_ENV_NEO=$NEXT
                printLine "$SEE_ENV_NEO - Ver Arquivo de configuração config.php"
                NEXT=$(echo $(($NEXT+1)))
                ALTER_ENV_NEO=$NEXT
                printLine "$ALTER_ENV_NEO - Alterar Arquivo de configuração config.php"
                NEXT=$(echo $(($NEXT+1)))
            fi

            if validFile $DIRECTORY'/composer.json'; then
                COMPOSER_ENV=$NEXT
                printLine "$COMPOSER_ENV - Composer Update"
                NEXT=$(echo $(($NEXT+1)))
            fi

            if validNpm $DIRECTORY; then
                NPM_UPDATE=$NEXT
                printLine "$NPM_UPDATE - NPM Update"
                NEXT=$(echo $(($NEXT+1)))
            fi


            if function_exists $FUNCTION_DATABASE; then
                 UPDATE_DATABASE=$NEXT
                 NEXT=$(echo $(($NEXT+1)))
                 printLine "$UPDATE_DATABASE  - Atualizar Banco de Dados"
                 SEE_PASS=$NEXT
                 NEXT=$(echo $(($NEXT+1)))
                 printLine "$SEE_PASS  - Ver Senha do Banco de Dados"
            fi
        fi
        printLine "0 - Voltar" "branco" "negrito"
        printInBar "s - Sair" "vermelho"
        read -p "| Informe a opção desejada >_ " OPTION

        clear

        case $OPTION in
          'S')
              printInBar "Execução finalizada!" "verde"
              exit
          ;;
          's')
              printInBar "Execução finalizada!" "verde"
              exit
          ;;
          0) break
          ;;
          1) install "$1" "$2" "$3"
          ;;
          2)
             read -e -p  "Informe a Nova URL: >_ " -i "$URL" VAR
             updateEnv "$2_URL=" $VAR
             reloadEnv
             clear
             printInBar "URL atualizada com Sucesso!" "verde"
          ;;
          3)
            if isValidInstall $2; then
                restartContainer $CONTAINER
            else
                printInBar "Opção inválida!" "vermelho"
            fi
          ;;
          4)
            if isValidInstall $2; then
                logContainer $CONTAINER
            else
                printInBar "Opção inválida!" "vermelho"
            fi
          ;;
          5)
            cd $DIRECTORY
            exec bash
          ;;
           $STOPC)
            if verifyContainerStarted $CONTAINER; then
                msgConfig 'Parando Container:'
                STOPCONTAINER=$(docker stop -t 0 $CONTAINER)

                if [ $STOPCONTAINER == $CONTAINER ]; then
                    printInBar 'Container Parado' 'verde'
                else
                    printInBar 'Erro ao Parar Container: '$STOPCONTAINER 'vermelho'
                fi
            else
                printInBar "Opção inválida!" "vermelho"
            fi
          ;;
          $ENTERC)
            if isValidInstall $2 && verifyContainerStarted $CONTAINER; then
                docker exec -ti $CONTAINER  /bin/bash
            else
                printInBar "Opção inválida!" "vermelho"
            fi
          ;;
          $SEE_ENV)
            clear
            if validFile $DIRECTORY'/.env' && isValidInstall $2; then
                printInBar 'Arquivo de Configuração'
                less $DIRECTORY'/.env'
                echo -e "\n"
            else
                printInBar 'Projeto não tem arquivo de configuração .env' 'vermelho'
            fi
          ;;
          $ALTER_ENV)

            if validFile $DIRECTORY'/.env'  && isValidInstall $2; then
                vi $DIRECTORY'/.env'
            else
                printInBar 'Projeto não tem arquivo de configuração .env' 'vermelho'
            fi
          ;;

          $SEE_ENV_NEO)
            clear
            if validFile $DIRECTORY'/config.php' && isValidInstall $2; then
                printInBar 'Arquivo de Configuração'
                less $DIRECTORY'/config.php'
                echo -e "\n"
            else
                printInBar 'Projeto não tem arquivo de configuração config.php' 'vermelho'
            fi
          ;;
          $ALTER_ENV_NEO)

            if validFile $DIRECTORY'/config.php'  && isValidInstall $2; then
                vi $DIRECTORY'/config.php'
            else
                printInBar 'Projeto não tem arquivo de configuração config.php' 'vermelho'
            fi
          ;;

          $COMPOSER_ENV)
            if validFile "$DIRECTORY/composer.json" && isValidInstall $2; then
            clear
            msgConfig "Executando Composer Update no Diretório $DIRECTORY"
            docker run --rm -v $DIRECTORY:/app composer update --ignore-platform-reqs --no-scripts
            else
                printInBar "Opção inválida!" "vermelho"
            fi

          ;;

          $NPM_UPDATE)
            if validNpm $DIRECTORY && isValidInstall $2; then
            clear
            msgConfig 'Realizando Npm Update'
            docker run --rm -v $DIRECTORY:/app kaiocarvalhopravaler/node:9 npm update
            else
                printInBar "Opção inválida!" "vermelho"
            fi

          ;;

          $UPDATE_DATABASE)
            if function_exists $FUNCTION_DATABASE && isValidInstall $2; then
                if validDatabase; then
                    $FUNCTION_CHANGE_DATABASE
                    printInBar "Banco de dados atualizado com Sucesso!" "verde"
                else
                    if registerDatabase; then
                        if $FUNCTION_CHANGE_DATABASE; then
                            printInBar "Banco de dados atualizado com Sucesso!" "verde"
                        else
                            printInBar "Banco de dados não foi atualizado" "vermelho"
                        fi
                    else
                        printInBar "Banco de dados não foi atualizado, devido não ter sido cadastrado" "vermelho"
                    fi
                fi
            else
                printInBar "Opção inválida!" "vermelho"
            fi
          ;;
          $SEE_PASS)
                if function_exists $FUNCTION_DATABASE && isValidInstall $2; then
                    echo -e "\033[01;37mSenha no Integração: \033[00;37m\033[01;$COR_PASSWORD$DATABASE_PASSWORD \033[00;37m"
                    if [ $SYSTEM_DB_PASSWORD != $DATABASE_PASSWORD ]; then
                        echo -e "\033[01;37mSenha no Sistema: \033[00;37m\033[01;31m$SYSTEM_DB_PASSWORD\033[00;37m"
                    fi
                    sleep 3
                    clear
                 else
                    printInBar "Opção inválida!" "vermelho"
                fi
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}
