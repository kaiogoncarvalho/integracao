#!/bin/bash
#!/usr/bin/env bash

# função isValidDirectory: verifica se o primeiro parâmetro passado na instancialização da função é um diretório válido
isValidDirectory() {
  [ -d $1 ]
}

# função isNotEmptyDirectory: verifica se o primeiro parâmetro passado na instancialização da função não é um diretório vazio
isNotEmptyDirectory() {
  [ "$(ls -A $1)" ]
}

# função isEmptyVariable: verifica se a váriavel existe
isEmptyVariable() {
  [ -z $1 ]
}


# função isValidRepository: utiliza a função isValidDirectory e isNotEmptyDirectory para verificar se o primeiro parâmetro passado na instancialização da função é um repositório válido
isValidRepository() {
  if isValidDirectory $1; then
    if isNotEmptyDirectory $1; then
        if isEmptyVariable $1; then
         false
        else
         true
        fi
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

# função printHeader: imprime o header padrão das saidas aplicação
printHeader() {
  lineDelimiter
  echo "| ${1}"
  lineDelimiter
}

# função printLine: imprime uma linha na formatação padrão das saidas da aplicação
printLine() {
  echo "| ${1}"
}

# função printPopup: imprime um popup
printPopup() {
  size=${#1}
  i=-3
  while [ $i -le $size ]; do
    echo -n "#"
    i=$((i+1))
  done
  echo -e
  echo "# $1 #"
  j=-3
  while [ $j -le $size ]; do
    echo -n "#"
    j=$((j+1))
  done
  echo -e
}
