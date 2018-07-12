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
3. Ter Acesso o repositório do projeto que vai ser instalado;


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
   
    
        
## Testar os sistemas
1. Para testar é necessário acessar a seguinte URL:
    * **Ambientes** 
        * **Agendamento de Homologação:** http://agendamento.homologacao.desenv
        * **API Apartada:** http://api.apartada.desenv
        * **API Pravaler:** http://api.pravaler.desenv
        * **Backoffice:** http://backoffice.desenv   
        * **CDN:** http://cdn.portalpravaler.desenv
        * **CreditScore:** http://creditscore.desenv
        * **FTP Risco e Cobrança:** http://ftp.risco-cobranca.desenv       
        * **Portal Pravaler:** http://portalpravaler.desenv        
        * **Nova Proposta Backend:** http://cadastro.creditouniversitario.desenv
        * **Nova Proposta Frontend:** http://cadastro.portalpravaler.desenv
        * **Retorno Mec:** http://lo.retornomec.idealinvest.srv.br
        * **Seguros:** http://seguros.idealinvest.desenv      

    * **Ambientes Neo** 
        * **Neo Proposal:** http://lo.proposal.idealinvest.srv.br
        * **Neo Integration:** http://lo.integration.idealinvest.srv.br
        * **Neo Student:** http://lo.student.idealinvest.srv.br
        * **Neo Negotiation:** http://lo.negotiation.idealinvest.srv.br
        * **Alfred Server:** http://lo.callcenter.idealinvest.srv.br
        * **Alfred Client:** http://lo.atendimento.idealinvest.com.br
        * **Neo Log:** http://lo.log.idealinvest.srv.br
        * **Neo Api:** http://lo.api.idealinvest.srv.br
    
# Opcional: Instalar o Xdebug
1. Para instalar o xdebug no **PHPSTORM**, use o seguinte passo a passo:
    * https://slimwiki.com/ideal-invest/instalar-o-xdebug-no-phpstorm
2. Para instalar o xdebug no **NETBEANS**, use o seguinte passo a passo:
    * https://slimwiki.com/ideal-invest/instalar-o-xdebug-no-netbeans-com-docker