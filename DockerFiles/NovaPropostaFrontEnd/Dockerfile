FROM centos:7
MAINTAINER Marcos Martins dos Santos

ENV NGINX_USERNAME=www-data
ENV NGINX_GROUPNAME=www-data
ENV NGINX_VERSION=nginx-1.10.2
ENV PROJECT_USERNAME=proposta
ENV PROJECT_USERNAME_GROUP=proposta
ENV PROJECT_FOLDER=/var/www/html/$PROJECT_USERNAME
ENV PROJECT_PUBLIC_FOLDER=$PROJECT_FOLDER/public/app

ADD DockerFiles/NovaPropostaFrontEnd/Files/install_centos_update.sh /usr/local
ADD DockerFiles/NovaPropostaFrontEnd/Files/configure_npm.sh /usr/local
ADD DockerFiles/NovaPropostaFrontEnd/Files/configure_nginx.sh /usr/local
ADD DockerFiles/NovaPropostaFrontEnd/Files/configure_project_user_data.sh /usr/local

RUN ./usr/local/install_centos_update.sh
RUN ./usr/local/configure_npm.sh
RUN ./usr/local/configure_nginx.sh

ADD DockerFiles/NovaPropostaFrontEnd/Files/nginx.conf /usr/local/$NGINX_VERSION/conf
ADD DockerFiles/NovaPropostaFrontEnd/Files/proposta.conf /usr/local/$NGINX_VERSION/conf/apps
ADD DockerFiles/NovaPropostaFrontEnd/Files/script.sh /usr/local

RUN ./usr/local/configure_project_user_data.sh

ADD DockerFiles/NovaPropostaFrontEnd/Files/environment.ts /home/proposta

EXPOSE 80 4200

ENTRYPOINT ["/bin/sh", "/usr/local/script.sh"]