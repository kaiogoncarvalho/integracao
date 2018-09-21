#!/bin/bash
#!/usr/bin/env bash

#Variável de Integração
INTEGRACAO_DIR=$(pwd)
# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
#Variáveis do ENV
ENV=$INTEGRACAO_DIR/.env
#Env Example
ENV_EXAMPLE=$INTEGRACAO_DIR/example.env


. $HELPERS

verifySudo

configEnvIntegracao 'example.env'

msgConfig 'Executando a instalação do Integração'

if [ -h "/bin/integracao" ]; then
    rm -r /bin/integracao
fi

ln -rs ambientes.sh /bin/integracao

if [ -h "/bin/integracao" ]; then
    msgGeneral '- Instalado com Sucesso' 'verde' 'reverso'
else
    msgGeneral '- Erro ao realizar a instalação' 'vermelho' 'reverso'
fi

echo -e