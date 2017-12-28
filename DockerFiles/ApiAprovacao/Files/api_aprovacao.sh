export API_APROVACAO_DIR=$(grep -E "APIAPROVACAO_LOCAL=(.*)" ../../../.env | sed -n 's/^APIAPROVACAO_LOCAL=*//p' ../../../.env)
cd $API_APROVACAO_DIR
composer install
cd config/
cp database.example.php database.php
cp serasa.example.php serasa.php