# Integração de todos os Sistemas

Criar o ambiente de todos os Sistemas de uma vez

### ***Pré-requisitos:

1. Ter o Docker instalado:
    * `sudo apt-get install docker.io`
    * `sudo groupadd docker`
    * `sudo gpasswd -a $(whoami) docker`
2. Ter Docker-Compose instalado;
    * sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-\`uname -s\`-\`uname -m` -o /usr/bin/docker-compose
    * sudo chmod +x /usr/bin/docker-compose
3. Ter Acesso a um dos repositórios abaixo:
    * **Observação: Somente os repositórios que tem acesso irão funcionar, mas não é necessário ter acesso a todos, se tiver acesso a somente um já é o suficiente.**
    * Backoffice: http://10.10.100.75/ideal-invest/BO-PRV
    * Portal Pravaler **(Portal Pravaler necessita do Backoffice)**: http://10.10.100.75/portalpravaler/portalpravaler.git 
    * API Pravaler: http://10.10.100.75/pravaler/api-pravaler.git
    * API Apartada: http://10.10.100.75/ideal-invest/BO-PRV-API.git
    * CreditScore: http://10.10.100.75/bsy.jhones/credit-score.git

# Usage

1. Fazer o clone deste repositório:
    * **Observação:** Caso queira deixar usuario e senha pré-definido, 
    usar o seguinte comando:
         * `git clone http://[usuario]:[senha]@10.10.100.75/ambientes/integracao.git`
         * Se a senha ou usuario tiver caracteres especiais, 
         procurar o código do caractere, 
         por exemplo para o caractere **@** usa-se **%40**
    * Caso não queira, usar esse comando:     
        * `git clone http://10.10.100.75/ambientes/integracao.git`

       
## Integração
1. Acessar a pasta do repositório da Integração:
2. Configurar os ambientes:
    * `sudo bash ambientes.sh` 
    * **Importante: Ser executado em sudo**    
3. Seguir o passo a passo do Instalador e instalar os sistemas desejados;
4. Todos os containers criados serão iniciados automaticamente;
5. Quando necessário iniciar ou parar os containers:
    * Iniciar container:
        * `docker start <container name>`
    * Parar container:
        * `docker stop <container name>`    
    
        
## Testar os sistemas
1. Para testar é necessário acessar a seguinte URL:
    * **CDN:** http://cdn.portalpravaler.desenv
    * **Backoffice:** http://backoffice.desenv
    * **Portal Pravaler:** http://portalpravaler.desenv
    * **API Pravaler:** http://api.pravaler.desenv
    * **API Apartada:** http://api.apartada.desenv
    * **CreditScore:** http://creditscore.desenv
    * **Agendamento de Homologação:** http://agendamento.homologacao.desenv
    * **Nova Proposta Backend:** http://cadastro.creditouniversitario.desenv
    * **Nova Proposta Frontend:** http://cadastro.portalpravaler.desenv
    
# Opcional: Instalar o Xdebug
1. Para instalar o xdebug no **PHPSTORM**, use o seguinte passo a passo:
    * https://slimwiki.com/ideal-invest/instalar-o-xdebug-no-phpstorm
2. Para instalar o xdebug no **NETBEANS**, use o seguinte passo a passo:
    * https://slimwiki.com/ideal-invest/instalar-o-xdebug-no-netbeans-com-docker