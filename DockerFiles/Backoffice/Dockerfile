FROM kaioidealinvest/php5.6
MAINTAINER Kaio Gonçalves Carvalho

COPY DockerFiles/Backoffice/Files/api.backoffice.conf /etc/apache2/sites-available/
COPY DockerFiles/Backoffice/Files/site.conf /etc/apache2/sites-available/site.conf

RUN a2ensite site.conf
RUN a2ensite api.backoffice.conf
