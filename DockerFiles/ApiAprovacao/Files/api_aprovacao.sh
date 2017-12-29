export DIR=$(grep -E "APIAPROVACAO_LOCAL=(.*)" ../../../.env | sed -n 's/^APIAPROVACAO_LOCAL=*//p' ../../../.env)
docker run --rm -v $DIR/:/app kaioidealinvest/composer:php7.1 install
cd $DIR
cd config/
cp database.example.php database.php
cp serasa.example.php serasa.php