FROM centos:7
MAINTAINER Marcos Martins dos Santos

ENV NGINX_USERNAME=www-data
ENV NGINX_GROUPNAME=www-data
ENV NGINX_VERSION=nginx-1.10.2
ENV PROJECT_USERNAME=alfred-client
ENV PROJECT_USERNAME_GROUP=alfred-client
ENV PROJECT_FOLDER=/var/www/html/$PROJECT_USERNAME
ENV PROJECT_PUBLIC_FOLDER=$PROJECT_FOLDER/public/app

ADD DockerFiles/Neo/AlfredClient/Files/install_centos_update.sh /usr/local
ADD DockerFiles/Neo/AlfredClient/Files/configure_npm.sh /usr/local
ADD DockerFiles/Neo/AlfredClient/Files/configure_nginx.sh /usr/local
ADD DockerFiles/Neo/AlfredClient/Files/configure_project_user_data.sh /usr/local
ADD DockerFiles/Neo/AlfredClient/Files/configure_bower.sh  /usr/local

RUN ./usr/local/install_centos_update.sh
RUN ./usr/local/configure_npm.sh
RUN ./usr/local/configure_nginx.sh
RUN ./usr/local/configure_bower.sh

ADD DockerFiles/Neo/AlfredClient/Files/nginx.conf /usr/local/$NGINX_VERSION/conf
ADD DockerFiles/Neo/AlfredClient/Files/alfred-client.conf /usr/local/$NGINX_VERSION/conf/apps
ADD DockerFiles/Neo/AlfredClient/Files/script.sh /usr/local

RUN ./usr/local/configure_project_user_data.sh

ADD DockerFiles/Neo/AlfredClient/Files/environment.ts /home/alfred-client

EXPOSE 80 4200

ENTRYPOINT ["/bin/sh", "/usr/local/script.sh"]