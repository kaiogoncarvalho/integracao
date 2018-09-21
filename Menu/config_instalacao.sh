#!/usr/bin/env bash

configInstalacao(){
     while true;
    do
        printInBar "Ambientes Pravaler" "ciano"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        printInBar "Configurações de Instalação" 'amarelo'
        echo -e
        echo -e "\033[01;37mTipo: \033[00;37m\033[01;32m$TIPO_INSTALACAO\033[00;37m"
        echo -e "\033[01;37mServidor: \033[00;37m\033[01;32m$NAME_SERVER\033[00;37m"
        echo -e
        printInBar "Menu" "verde"
        printLine "1  - Alterar Tipo de Instalação"
        printLine "2  - Reiniciar Todos Containers"
        printLine "3  - Acessar Diretório do Integração"
        printLine "4  - Atualizar a Branch do Integração"


        if [ $TIPO_INSTALACAO == 'servidor' ]; then
            printLine "5  - Alterar URL's em massa"
            printLine "6  - Instalar/Reinstalar Nginx dos Sistemas"
        fi

        printLine "0  - Voltar" "azul" "negrito"
        printInBar "s - Sair" "vermelho"
        read -p "| Informe a opção desejada >_ " OPTION

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
          1)
            echo -e
            printInBar "Tipo de Instalação" "verde"
            printLine "1  - Normal"
            printLine "2  - Servidor"
            printLine "0  - Voltar" "azul" "negrito"
            printInBar "s - Sair" "vermelho"
            read -p "| Informe a opção desejada >_ " TIPO
            case $TIPO in
            'S')
                clear
                printInBar "Execução finalizada!" "verde"
                 exit
              ;;
              's')
              clear
                  printInBar "Execução finalizada!" "verde"
                  exit
              ;;
            0) clear
            ;;
            1)
               updateEnv "TIPO_INSTALACAO=" 'normal'
               IP=$(getHostIp)
               regexFile 'HOST_IP=' $IP
               reloadEnv
               clear
               printInBar "Tipo de Instalação Atualizado com Sucesso!" "verde"
            ;;
            2)
               updateEnv "TIPO_INSTALACAO=" 'servidor'
               regexFile 'HOST_IP=' ''
               reloadEnv
               clear
               printInBar "Tipo de Instalação  Atualizado com Sucesso!" "verde"
            ;;
            *) printInBar "Opção inválida!" "vermelho"
            ;;
            esac
          ;;
          2)
            msgConfig 'Reiniciando Containers: \n'
            SISTEMS=$(getSystems)
            for i in $SISTEMS
            do
                CONTAINER=$(getEnv $i"_CONTAINER")
                docker restart -f $CONTAINER
            done
          ;;
          3)
            cd $INTEGRACAO_DIR
            exec bash
          ;;
          4)
               updateBranch $INTEGRACAO_DIR
          ;;
          5)
           if [ $TIPO_INSTALACAO == 'servidor' ]; then
             echo -e
            printInBar "Escolha o Tipo de URL" "verde"
            printLine "1  - Risco e Financeiro"
            printLine "2  - Melhoria Contínua"
            printLine "3  - Escolher Prefixo/Sufixo"
            printLine "0  - Voltar" "branco" "negrito"
            printInBar "s - Sair" "vermelho"
            read -p "| Informe a opção desejada >_ " TIPO_URL
            case $TIPO_URL in
            'S')
                clear
                printInBar "Execução finalizada!" "verde"
                 exit
              ;;
              's')
              clear
                  printInBar "Execução finalizada!" "verde"
                  exit
              ;;
            0) clear
            ;;
            1)
               clear
               updateUrlLote 'rf'
               updateEnv "NAME_SERVER=" 'rf'
               reloadEnv
               printInBar "URL's Atualizadas com Sucesso!" "verde"
            ;;
            2)
               clear
               updateUrlLote 'mc'
               updateEnv "NAME_SERVER=" 'mc'
               reloadEnv
               printInBar "URL's Atualizadas com Sucesso!" "verde"
            ;;
            3)
               clear
               read -p "| Informe o Prefixo/Sufixo das URL's >_ " PREFIX
               updateUrlLote "$PREFIX"
               updateEnv "NAME_SERVER=" "$PREFIX"
               reloadEnv
               printInBar "URL's Atualizadas com Sucesso!" "verde"
            ;;
            *) printInBar "Opção inválida!" "vermelho"
            ;;
            esac
           else
            printInBar "Opção inválida!" "vermelho"
           fi

          ;;
           6)
           if [ $TIPO_INSTALACAO == 'servidor' ]; then
                configServer
           else
            printInBar "Opção inválida!" "vermelho"
           fi
           ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}
