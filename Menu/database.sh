#!/usr/bin/env bash

database(){
     while true;
    do
        printInBar "Ambientes Pravaler" "verde"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        echo -e
        printInBar "Banco de Dados"
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
          1) databaseHost
             clear
             printInBar "Atualizado com Sucesso!" "ciano"
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
