#!/usr/bin/env bash

DIR=$(grep -E "APIAPROVACAO_LOCAL=(.*)" ../../../.env | sed -n 's/^APIAPROVACAO_LOCAL=*//p' ../../../.env)
DB=$(grep -E "DATABASE=(.*)" ../../../.env | sed -n 's/^DATABASE=*//p' ../../../.env)
docker run --rm -v $DIR/:/app kaioidealinvest/composer:php7.1 install
cd $DIR
cd config/
cp database.example.php database.php
sed -i -E "s/10.10.100.110/$DB/g" database.php
sed -i -E "s/''/'123456'/g" database.php
cp serasa.example.php serasa.php