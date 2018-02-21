#!/usr/bin/env bash

install_npm() {

curl -sL https://rpm.nodesource.com/setup_9.x | bash -
yum install -y nodejs

}

install_npm