#!/usr/bin/env bash

detalhe(){
     while true;
    do
        CONTAINER=$(getEnv "$2_CONTAINER")
        URL=$(getEnv "$2_URL")
        IP=$(getEnv "$2_IP")
        STATUS=''

        if [ $3 == 'service' ]; then
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
            echo -e "\033[01;37mBranch: \033[00;37m\033[01;32m$BRANCH\033[00;37m"
            if validURL $CONTAINER $URL; then
                COR_URL='32m'
            else
                COR_URL='31m'
                STATUS=$STATUS"\033[07;31m- URL do Container Diferente, URLS válidas: $ALIASES (necessário reinstalar o Sistema)\033[00;31m\n\n"
            fi

            echo -e "\033[01;37mURL: \033[00;37m\033[01;$COR_URL$URL \033[00;37m"
            echo -e "\033[01;37mIP: \033[00;37m\033[01;32m$IP\033[00;37m"
        else
            echo -e "\033[01;37mURL: \033[00;37m\033[01;31m$URL \033[00;37m"
            echo -e "\033[01;37mIP: \033[00;37m\033[01;31m$IP\033[00;37m"
            STATUS="\033[07;31m- Ambiente não Instalado\033[00;31m\n"
        fi

        if function_exists $FUNCTION_DATABASE && isValidInstall $2; then
            $FUNCTION_DATABASE
            deleteContainer 'php_cli'
            echo -e
            echo -e "\033[07;37mBanco de Dados Backoffice\n\033[00;37m"

            if [ $SYSTEM_DB_HOST == $DATABASE_HOST ]; then
                COR_HOST='32m'
            else
                COR_HOST='31m'
                STATUS=$STATUS"\033[07;31m- Host do Banco de Dados Diferente, Host: $DATABASE_HOST (necessário atualizar o banco de dados)\033[00;31m\n\n"
            fi

            if [ $SYSTEM_DB_PORT == $DATABASE_PORT ]; then
                COR_PORT='32m'
            else
                COR_PORT='31m'
                STATUS=$STATUS"\033[07;31m- Porta do Banco de Dados Diferente, Porta: $DATABASE_PORT (necessário atualizar o banco de dados)\033[00;31m\n\n"
            fi

            if [ $SYSTEM_DB_NAME == $DATABASE_NAME ]; then
                COR_NAME='32m'
            else
                COR_NAME='31m'
                STATUS=$STATUS"\033[07;31m- Nome do Banco de Dados Diferente, Nome: $DATABASE_NAME (necessário atualizar o banco de dados)\033[00;31m\n\n"
            fi

            if [ $SYSTEM_DB_USER == $DATABASE_USER ]; then
                COR_USER='32m'
            else
                COR_USER='31m'
                STATUS=$STATUS"\033[07;31m- Usuário do Banco de Dados Diferente, Usuário: $DATABASE_USER (necessário atualizar o banco de dados)\033[00;31m\n\n"
            fi

            if [ $SYSTEM_DB_PASSWORD == $DATABASE_PASSWORD ]; then
                COR_PASSWORD='32m'
            else
                COR_PASSWORD='31m'
                STATUS=$STATUS"\033[07;31m- Senha do Banco de Dados Diferente (necessário atualizar o banco de dados)\033[00;31m\n\n"
            fi

            echo -e "\033[01;37mHost: \033[00;37m\033[01;$COR_HOST$SYSTEM_DB_HOST\033[00;37m"
            echo -e "\033[01;37mPorta: \033[00;37m\033[01;$COR_PORT$SYSTEM_DB_PORT \033[00;37m"
            echo -e "\033[01;37mBanco: \033[00;37m\033[01;$COR_NAME$SYSTEM_DB_NAME\033[00;37m"
            echo -e "\033[01;37mUsuário: \033[00;37m\033[01;$COR_USER$SYSTEM_DB_USER\033[00;37m"
        fi
        echo -e
        echo -e "\033[07;37mStatus\n\033[00;37m"
        if isEmptyVariable $STATUS;then
            STATUS="\033[07;32m- Ambiente Instalado\033[00;31m\n"
        fi

        echo -e $STATUS

        printInBar "Menu" "verde"
        printLine "1  - Instalar/Reinstalar"
        printLine "2  - Alterar URL"
        if isValidInstall $2; then
            printLine "3  - Reiniciar Container"
            printLine "4  - Consultar Log"
            if function_exists $FUNCTION_DATABASE; then
                 printLine "5  - Atualizar Banco de Dados"
                 printLine "6  - Ver Senha do Banco de Dados"
            fi
        fi
        printLine "0  - Voltar" "branco" "negrito"
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
            if function_exists $FUNCTION_DATABASE && isValidInstall $2; then
                $FUNCTION_CHANGE_DATABASE
                printInBar "Banco de dados atualizado com Sucesso!" "verde"
            else
                printInBar "Opção inválida!" "vermelho"
            fi
          ;;
          6)
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
