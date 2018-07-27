#!/usr/bin/env bash

detalhe(){
     while true;
    do
        CONTAINER=$(getEnv "$2_CONTAINER")
        URL=$(getEnv "$2_URL")
        IP=$(getEnv "$2_IP")

        printInBar "Detalhe Sistema" "verde"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        echo -e
        printInBar "Sistema $1"
         echo -e
        msgGeneral "\033[07;37mInformações\n\033[00;37m"
        msgGeneral "\033[01;37mContainer: \033[00;37m\033[01;32m$CONTAINER\033[00;37m"
        msgGeneral "\033[01;37mURL: \033[00;37m\033[01;31m$URL \033[00;37m"
        msgGeneral "\033[01;37mIP: \033[00;37m\033[01;32m$IP\033[00;37m"
        echo -e
        msgGeneral "\033[07;37mBanco de Dados\n\033[00;37m"
        msgGeneral "\033[01;37mHost: \033[00;37m\033[01;32m$DATABASE_HOST\033[00;37m"
        msgGeneral "\033[01;37mPorta: \033[00;37m\033[01;31m$DATABASE_PORT \033[00;37m"
        msgGeneral "\033[01;37mBanco: \033[00;37m\033[01;32m$DATABASE_NAME\033[00;37m"
        msgGeneral "\033[01;37mUsuário: \033[00;37m\033[01;32m$DATABASE_USER\033[00;37m"
        msgGeneral "\033[01;37mSenha: \033[00;37m\033[01;32m$DATABASE_PASSWORD\033[00;37m"       
        echo -e
        msgGeneral "\033[07;37mStatus\n\033[00;37m"
        msgGeneral "\033[07;31mURL Diferente (necessário reinstalar)\033[00;37m"
        echo -e
        printInBar "Menu" "verde"
        printLine "1  - Instalar/Reinstalar"
        printLine "2  - Consultar Log"
        printLine "3  - Atualizar Banco de Dados"
        printLine "4  - Alterar URL"
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
             clear
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
          5) databasePassword
             clear
             printInBar "Atualizado com Sucesso!" "ciano"
          ;;
          6)
           msgGeneral "Senha: $DATABASE_PASSWORD" "branco" "negrito"
            sleep 1
            clear
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}
