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
        else
            FUNCTION_DATABASE='display_database_'$CONTAINER
        fi

        printInBar "Detalhe Sistema" "ciano"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        echo -e
        printInBar "Sistema $1" "branco" "negrito"
         echo -e
        echo -e "\033[07;37mInformações\n\033[00;37m"

        if isValidInstall $2; then
            BRANCH=$(getBranch $2)
            echo -e "\033[01;37mContainer: \033[00;37m\033[01;32m$CONTAINER\033[00;37m"
            echo -e "\033[01;37mBranch: \033[00;37m\033[01;32m$BRANCH\033[00;37m"
            echo -e "\033[01;37mURL: \033[00;37m\033[01;32m$URL \033[00;37m"
            echo -e "\033[01;37mIP: \033[00;37m\033[01;32m$IP\033[00;37m"
        else
            echo -e "\033[01;37mURL: \033[00;37m\033[01;31m$URL \033[00;37m"
            echo -e "\033[01;37mIP: \033[00;37m\033[01;31m$IP\033[00;37m"
            STATUS="\033[07;31m- Ambiente não Instalado\033[00;31m"
        fi

        if function_exists $FUNCTION_DATABASE && isValidInstall $2; then
            $($FUNCTION_DATABASE)
            echo -e
            echo -e "\033[07;37mBanco de Dados\n\033[00;37m"
            echo -e "\033[01;37mHost: \033[00;37m\033[01;32m$SYSTEM_DB_HOST\033[00;37m"
            echo -e "\033[01;37mPorta: \033[00;37m\033[01;31m$SYSTEM_DB_PORT \033[00;37m"
            echo -e "\033[01;37mBanco: \033[00;37m\033[01;32m$SYSTEM_DB_NAME\033[00;37m"
            echo -e "\033[01;37mUsuário: \033[00;37m\033[01;32m$SYSTEM_DB_USER\033[00;37m"
            echo -e "\033[01;37mSenha: \033[00;37m\033[01;32m$SYSTEM_DB_PASSWORD\033[00;37m"
        fi
        echo -e
        echo -e "\033[07;37mStatus\n\033[00;37m"
        if isEmptyVariable $STATUS;then
            STATUS="\033[07;32m- Ambiente Instalado\033[00;31m"
        fi

        echo -e $STATUS
        echo -e
        printInBar "Menu" "verde"
        printLine "1  - Instalar/Reinstalar"
        printLine "2  - Alterar URL"
        if isValidInstall $2; then
            printLine "3  - Consultar Log"
            if function_exists $FUNCTION_DATABASE; then
                 printLine "4  - Atualizar Banco de Dados"
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
          1) install $1 $2 $3
          ;;
          2) databasePort
             clear
             printInBar "Atualizado com Sucesso!" "ciano"
          ;;
          3) databaseName
             clear
             printInBar "Atualizado com Sucesso!" "ciano"
          ;;
          4) databaseUser
             clear
             printInBar "Atualizado com Sucesso!" "ciano"
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}
