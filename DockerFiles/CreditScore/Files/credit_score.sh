#!/usr/bin/env bash

DIR=$(grep -E "CREDITSCORE_LOCAL=(.*)" ../../../.env | sed -n 's/^CREDITSCORE_LOCAL=*//p' ../../../.env)
docker run --rm -v $DIR/:/app kaioidealinvest/composer:php7.1 install