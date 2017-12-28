export BACKOFFICE_DIR=$(grep -E "BACKOFFICE_LOCAL=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_LOCAL=*//p' ../../../.env)
cd $BACKOFFICE_DIR
composer install
cp sample.env .env
cd html/portal/pravaler/
mkdir log
cd backoffice/
mkdir cnab
cd cnab
mkdir bancos
cd bancos
mkdir db
cd $BACKOFFICE_DIR
chmod 755 -R html/
