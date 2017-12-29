export DIR=$(grep -E "BACKOFFICE_LOCAL=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_LOCAL=*//p' ../../../.env)
docker run --rm -v $DIR/:/app kaioidealinvest/composer:php7.1 install
cd $DIR
cp sample.env .env
cd html/portal/pravaler/
mkdir log
cd backoffice/
mkdir cnab
cd cnab
mkdir bancos
cd bancos
mkdir db
cd $DIR
chmod 755 -R html/
