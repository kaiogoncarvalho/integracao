#!/bin/bash
#!/usr/bin/env bash

# função isValidDirectory: verifica se o primeiro parâmetro passado na instancialização da função é um diretório válido
isValidDirectory() {
  DIRECTORY=$1
  [ -d $DIRECTORY ]
}

# função isNotEmptyDirectory: verifica se o primeiro parâmetro passado na instancialização da função não é um diretório vazio
isNotEmptyDirectory() {
  DIRECTORY=$1
  [ "$(ls -A $DIRECTORY)" ]
}

# função isValidRepository: utiliza a função isValidDirectory e isNotEmptyDirectory para verificar se o primeiro parâmetro passado na instancialização da função é um repositório válido
isValidRepository() {
  DIRECTORY=$1
  if isValidDirectory $DIRECTORY; then
    if isNotEmptyDirectory $DIRECTORY; then
      true
    else
      false
    fi
  else
    false
  fi
}

# função lineDelimiter: imprime o delimitador padrão das saidas da aplicação
lineDelimiter() {
  echo "+---------------"
}

# função printLine: imprime uma linha na formatação padrão das saidas da aplicaçãoq
printLine() {
  MESSAGE=$1
  echo "| ${MESSAGE}"
}

# função printInBar: imprime um popup
printInBar() {
  MESSAGE=$1
  MESSAGE_SIZE=${#MESSAGE}
  i=-1
  echo -n "+"
  while [ $i -le $MESSAGE_SIZE ]; do
    echo -n "-"
    i=$((i+1))
  done
  echo -n "+"
  echo -e
  echo "| ${MESSAGE} |"
  echo -n "+"
  j=-1
  while [ $j -le $MESSAGE_SIZE ]; do
    echo -n "-"
    j=$((j+1))
  done
  echo -n "+"
  echo -e
}

# função performSetup: inicia a execução do setup de um projeto
performSetup() {
  METHOD=$1
  DIR=$2
  if isValidRepository $DIR; then
    printInBar "Configurando o ${PROJECT} em '${DIR}'"
    $METHOD $DIR
  else
    printInBar "ERRO: O diretório informado não é válido!"
  fi
}
