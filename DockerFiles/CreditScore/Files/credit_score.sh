cd $(grep -E "CREDITSCORE_LOCAL=(.*)" ../../../.env | sed -n 's/^CREDITSCORE_LOCAL=*//p' ../../../.env)
composer install