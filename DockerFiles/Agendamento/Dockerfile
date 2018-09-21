FROM kaiocarvalhopravaler/php:7.2-apache
MAINTAINER Kaio Gonçalves Carvalho

RUN mkdir /etc/apache2/ssl

COPY DockerFiles/Agendamento/Files/ssl/phpit.crt /etc/apache2/ssl
COPY DockerFiles/Agendamento/Files/ssl/phpit.key /etc/apache2/ssl
COPY DockerFiles/Agendamento/Files/ssl/phpit.pem /etc/apache2/ssl

COPY DockerFiles/Agendamento/Files/site.conf /etc/apache2/sites-available/site.conf

RUN a2enmod ssl
RUN a2ensite site.conf

