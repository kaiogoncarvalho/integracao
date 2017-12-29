# Variáveis que resgatam os diretórios dos projetos à partir do arquivo .env da aplicação
export API_APARTADA_DIR=$(grep -E "APIAPARTADA_LOCAL=(.*)" .env | sed -n 's/^APIAPARTADA_LOCAL=*//p' .env)
export API_APROVACAO_DIR=$(grep -E "APIAPROVACAO_LOCAL=(.*)" .env | sed -n 's/^APIAPROVACAO_LOCAL=*//p' .env)
export BACKOFFICE_DIR=$(grep -E "BACKOFFICE_LOCAL=(.*)" .env | sed -n 's/^BACKOFFICE_LOCAL=*//p' .env)
export CREDIT_SCORE_DIR=$(grep -E "CREDITSCORE_LOCAL=(.*)" .env | sed -n 's/^CREDITSCORE_LOCAL=*//p' .env)
export PORTAL_PRAVALER_DIR=$(grep -E "PORTALPRAVALER_LOCAL=(.*)" .env | sed -n 's/^PORTALPRAVALER_LOCAL=*//p' .env)

# função isValidDirectory: verifica se o primeiro parâmetro passado na instancialização da função é um diretório válido
isValidDirectory() {
  [ -d $1 ]
}

# função isNotEmptyDirectory: verifica se o primeiro parâmetro passado na instancialização da função não é um diretório vazio
isNotEmptyDirectory() {
  [ "$(ls -A $1)" ]
}

# função isValidRepository: utiliza a função isValidDirectory e isNotEmptyDirectory para verificar se o primeiro parâmetro passado na instancialização da função é um repositório válido
isValidRepository() {
  if isValidDirectory $1; then
    if isNotEmptyDirectory $1; then
      true
    else
      false
    fi
  else
    false
  fi
}

# Configura a API Apartada
setup_api_apartada() {
  cd $1
  chmod 777 -R portal
  cd portal/pravaler_v2/api/app
  mkdir log
}

# Configura a API de Aprovação da IES
setup_api_aprovacao() {
  docker run --rm -v $1/:/app kaioidealinvest/composer:php7.1 install
  cd $1
  cd config/
  cp database.example.php database.php
  cp serasa.example.php serasa.php
}

# Configura o Backoffice
setup_backoffice() {
  docker run --rm -v $1/:/app kaioidealinvest/composer:php7.1 install
  cd $1
  cp sample.env .env
  cd html/portal/pravaler/
  mkdir log
  cd backoffice/
  mkdir cnab
  cd cnab
  mkdir bancos
  cd bancos
  mkdir db
  cd $1
  chmod 755 -R html/
}

# Configura o Credit Score
setup_credit_score() {
  docker run --rm -v $1/:/app kaioidealinvest/composer:php7.1 install
}

# Configura o Portal Pravaler
setup_portal_pravaler() {
  docker run --rm -v $1/:/app kaioidealinvest/composer:php7.1 install --no-scripts
  docker run --rm -v $1/:/app kaioidealinvest/composer:php7.1 update --no-scripts
  docker run --rm -v $1/workbench/portal/analytics:/app kaioidealinvest/composer:php7.1 dump
  docker run --rm -v $1/workbench/portal/plugins:/app kaioidealinvest/composer:php7.1 dump
  docker run --rm -v $1/workbench/portal/pravaler-backoffice:/app kaioidealinvest/composer:php7.1 dump
  docker run --rm -v $1/workbench/portal/proposal:/app kaioidealinvest/composer:php7.1 dump
  docker run --rm -v $1/workbench/portal/marketplace:/app kaioidealinvest/composer:php7.1 dump
  cd $1
  chmod -R 777 app/storage
}

# Inicializa as funções de configuração dos projetos
main() {
  if isValidRepository $API_APARTADA_DIR; then
    echo "$API_APARTADA_DIR $( isValidRepository $API_APARTADA_DIR && echo ' (DIRETÓRIO OK)' || echo ' (DIRETÓRIO INVÁLIDO)')"
    # setup_api_apartada $API_APARTADA_DIR
  fi
  if isValidRepository $API_APROVACAO_DIR; then
    echo "$API_APROVACAO_DIR $( isValidRepository $API_APROVACAO_DIR && echo ' (DIRETÓRIO OK)' || echo ' (DIRETÓRIO INVÁLIDO)')"
    # setup_api_aprovacao $API_APROVACAO_DIR
  fi
  if isValidRepository $BACKOFFICE_DIR; then
    echo "$BACKOFFICE_DIR $( isValidRepository $BACKOFFICE_DIR && echo ' (DIRETÓRIO OK)' || echo ' (DIRETÓRIO INVÁLIDO)')"
    # setup_backoffice $BACKOFFICE_DIR
  fi
  if isValidRepository $CREDIT_SCORE_DIR; then
    echo "$CREDIT_SCORE_DIR $( isValidRepository $CREDIT_SCORE_DIR && echo ' (DIRETÓRIO OK)' || echo ' (DIRETÓRIO INVÁLIDO)')"
    # setup_credit_score $CREDIT_SCORE_DIR
  fi
  if isValidRepository $PORTAL_PRAVALER_DIR; then
    echo "$PORTAL_PRAVALER_DIR $( isValidRepository $PORTAL_PRAVALER_DIR && echo ' (DIRETÓRIO OK)' || echo ' (DIRETÓRIO INVÁLIDO)')"
    # setup_portal_pravaler $PORTAL_PRAVALER_DIR
  fi
}

main
