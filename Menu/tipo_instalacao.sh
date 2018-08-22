#!/usr/bin/env bash

tipoInstalacao(){
     while true;
    do
        printInBar "Ambientes Pravaler" "ciano"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        printInBar "Tipo de Instalação" 'amarelo'
        echo -e
        echo -e "\033[01;37mTipo: \033[00;37m\033[01;32m$TIPO_INSTALACAO\033[00;37m"
        echo -e "\033[01;37mServidor: \033[00;37m\033[01;32m$NAME_SERVER\033[00;37m"
        echo -e
        printInBar "Menu" "verde"
        printLine "1  - Alterar Tipo de Instalação"
        printLine "2  - Alterar IP do Xdebug para Teste"
        printLine "3  - Reiniciar todos Containers"
        printLine "4  - Acessar Diretório do Integração"


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
            msgConfig 'Alterando IP do Xdebug dos Containers: \n'

            read -e -p  "Informe o IP: >_ " -i  "$HOST_IP" ip

            regexFile 'HOST_IP=' $ip $INTEGRACAO_DIR"/.env"
            reloadEnv

            SISTEMS=$(getSystems)
            for i in $SISTEMS
            do
                CONTAINER=$(getEnv $i"_CONTAINER")
                HOST_IP_CONTAINER=''
                HOST_IP_CONTAINER=$(getHostIpByContainer $CONTAINER)

                if [ ! -z $HOST_IP_CONTAINER ] && verifyContainerStarted $CONTAINER; then
                    dockerComposeUp $CONTAINER
                fi

            done
            
            echo -e
          ;;
          3)
            msgConfig 'Reiniciando Containers: \n'
            SISTEMS=$(getSystems)
            for i in $SISTEMS
            do
                CONTAINER=$(getEnv $i"_CONTAINER")
                docker restart -f $CONTAINER
            done
          ;;
          4)
            cd $INTEGRACAO_DIR
            exec bash
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
