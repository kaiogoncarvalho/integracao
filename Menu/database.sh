#!/usr/bin/env bash

database(){
     while true;
    do
        printInBar "Ambientes Pravaler" "ciano"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        echo -e
        printInBar "Banco de Dados" "amarelo"
        echo -e
        msgGeneral "Host: $DATABASE_HOST"
        msgGeneral "Porta: $DATABASE_PORT"
        msgGeneral "Banco: $DATABASE_NAME"
        msgGeneral "Usuário: $DATABASE_USER"
        echo -e
        printInBar "Menu" "verde"
        printLine "1  - Alterar Host"
        printLine "2  - Alterar Porta"
        printLine "3  - Alterar Nome do Banco"
        printLine "4  - Alterar Usuário"
        printLine "5  - Alterar Senha"
        printLine "6  - Ver Senha"
        printLine "7  - Atualizar Banco de Dados dos Sistemas"
        printLine "0  - Voltar" "azul" "negrito"
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
          1) databaseHost
             clear
             printInBar "Atualizado com Sucesso!" "verde"
          ;;
          2) databasePort
             clear
             printInBar "Atualizado com Sucesso!" "verde"
          ;;
          3) databaseName
             clear
             printInBar "Atualizado com Sucesso!" "verde"
          ;;
          4) databaseUser
             clear
             printInBar "Atualizado com Sucesso!" "verde"
          ;;
          5) databasePassword
             clear
             printInBar "Atualizado com Sucesso!" "verde"
          ;;
          6)
           msgGeneral "Senha: $DATABASE_PASSWORD" "branco" "negrito"
            sleep 3
            clear
          ;;
          7)
            msgConfig 'Atualizando Banco de dados do Backoffice nos Sistemas'

            if database_backoffice; then
                msgConfigItemSucess 'Banco de Dados do Backoffice Atualizado'
            fi

            if database_api_pravaler; then
                msgConfigItemSucess 'Banco de Dados do Backoffice na Api Pravaler Atualizado'
            fi

            if database_creditscore; then
                msgConfigItemSucess 'Banco de Dados do Backoffice no CreditScore Atualizado'
            fi

            if database_neo; then
                msgConfigItemSucess 'Banco de Dados do Backoffice no Neo Atualizado'
            fi

            if database_nova_proposta_backend; then
                msgConfigItemSucess 'Banco de Dados do Backoffice na Nova Proposta Backend Atualizado'
            fi

            if database_retornomec; then
                msgConfigItemSucess 'Banco de Dados do Backoffice no Retorno Mec Atualizado'
            fi

            if database_seguros; then
                msgConfigItemSucess 'Banco de Dados do Backoffice nos Seguros Atualizado'
            fi

            echo -e \n

            printInBar "Banco de Dados dos Sistemas instalados foram atualizado com Sucesso!" "verde"
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}
