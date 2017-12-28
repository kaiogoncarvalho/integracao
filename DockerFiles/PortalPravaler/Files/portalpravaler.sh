cd $(grep -E "PORTALPRAVALER_LOCAL=(.*)" ../../../.env | sed -n 's/^PORTALPRAVALER_LOCAL=*//p' ../../../.env)
composer install --no-scripts
composer update --no-scripts
chmod -R 777 app/storage
cd workbench/portal/analytics
composer dump
cd ..
cd plugins
composer dump
cd ..
cd pravaler-backoffice
composer dump
cd ..
cd proposal
composer dump
cd ..
cd marketplace
composer dump