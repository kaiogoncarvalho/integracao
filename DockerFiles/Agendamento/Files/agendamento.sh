export AGENDAMENTO_DIR=$(grep -E "AGENDAMENTO_LOCAL=(.*)" ../../../.env | sed -n 's/^AGENDAMENTO_LOCAL=*//p' ../../../.env)
export BACKOFFICE_DIR=$(grep -E "BACKOFFICE_LOCAL=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_LOCAL=*//p' ../../../.env)
cd $AGENDAMENTO_DIR
composer install
cp .env.example .env
cp $BACKOFFICE_DIR/.env $AGENDAMENTO_DIR/helpers/backoffice.env.bkp
chmod 777 -R $AGENDAMENTO_DIR

