#!/usr/bin/env bash

install_centos_update() {
    yum update -y
    yum groupinstall -y "Development Tools"
    yum install -y wget pcre pcre-devel openssl openssl-devel
}

install_centos_update