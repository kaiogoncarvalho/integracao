<?php

if (!defined('ENVIRONMENT')) {
    define('ENVIRONMENT', 'lo');
}

return array(

    'base_url'      => 'http://st.bpm.idealinvest.com.br',
    'product-front' => array('host' => 'http://st.product.idealinvest.com.br'),

    'api'             => array('host' => 'http://st.api.idealinvest.srv.br'),
    'assignment'      => array('host' => 'http://st.assignment.idealinvest.srv.br'),
    'bpm'             => array('host' => 'http://qa.bpm.idealinvest.com.br'),
    'creditscore'     => array('host' => 'http://st.creditscore.idealinvest.srv.br'),
    'email'           => array('host' => 'http://st.email.idealinvest.srv.br'),
    'fee'             => array('host' => 'http://st.fee.idealinvest.srv.br'),
    'integration'     => array('host' => 'http://st.integration.idealinvest.srv.br'),
    'institution'     => array('host' => 'http://st.institution.idealinvest.srv.br'),
    'log'             => array(
        'host' => 'http://lo.log.idealinvest.srv.br',
        'AWS_ACCESS_KEY_ID' => 'AKIAI5FI3JDFKNGCAIQA',
        'AWS_SECRET_ACCESS_KEY' => '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',
        'AWS_REGION' => 'sa-east-1',
        'VERSION' => '2012-08-10',
    ),
    'oauth'           => array('host' => 'http://qa.oauth.idealinvest.srv.br',),
    'people'          => array('host' => 'http://st.people.idealinvest.srv.br'),
    'product'         => array('host' => 'http://st.product.idealinvest.srv.br'),
    'proposal'        => array('host' => 'http://st.proposal.idealinvest.srv.br'),
    'retornomec'      => array('host' => 'http://st.retornomec.idealinvest.srv.br'),
    'student'         => array('host' => 'http://st.student.idealinvest.srv.br'),
    'negotiation'     => array('host' => 'http://st.negotiation.idealinvest.srv.br'),
    'spreadsheet'     => array('host' => 'http://st.spreadsheet.idealinvest.srv.br'),
    'subscriptionfee' => array('host' => 'http://st.fee.idealinvest.srv.br'),
    'backoffice'      => array(
        'host' => 'backoffice.desenv',
        'token' => '539a6c1ee350a8c21d56b68719a01caf'
    ),


    'admin' => array(
        ['name' => ('<nome>'), 'email' => ('<email>')]
    ),

    'clients' => [
        'clubedevantagens' => [
            'secret' => '123456',
            'name' => 'clubedevantagens',
            'redirect_uri' => '',
            'is_confidential' => true,
        ],
        'neo' => [
            'secret' => 'abc',
            'name' => 'neo',
            'redirect_uri' => '',
            'is_confidential' => true,
        ],
    ] ,

    'database'      => array(
        'default'   => array(
            'database'  => 'pgsql',
            'driver'    => 'pdo_pgsql',
            'host'      => '10.10.3.107',
            'port'      => '5432',
            'dbname'    => 'pravaler',
            'user'      => 'pravaler',
            'password'  => 'PRaVaLeR'
        ),
        'backoffice'    => array(
            'database'  => 'pgsql',
            'driver'    => 'pdo_pgsql',
            'host'      => '10.10.100.20',
            'port'      => '5432',
            'dbname'    => 'iipravaler',
            'user'      => 'iipravaler',
            'password'  => 'teste123'
        ),
        'invalido'        => array(
            'database'  => 'mysql',
            'driver'    => 'pdo_pgsql',
            'host'      => '10.10.3.107',
            'port'      => '3306',
            'dbname'    => 'db_errado',
            'user'      => 'para',
            'password'  => 'phpunit'
        ),
        'neo'           => array(
            'database'  => 'pgsql',
            'driver'    => 'pdo_pgsql',
            'host'      => '10.10.3.107',
            'port'      => '5432',
            'dbname'    => 'test',
            'user'      => 'pravaler',
            'password'  => 'PRaVaLeR'
        ),
        'portal'        => array(
            'database'  => 'mysql',
            'driver'    => 'pdo_mysql',
            'host'      => '10.10.3.107',
            'port'      => '3306',
            'dbname'    => 'portalpravaler_novo',
            'user'      => 'portal',
            'password'  => 'q1w2e3'
        ),
        'replica'    => array(
            'database'  => 'pgsql',
            'driver'    => 'pdo_pgsql',
            'host'      => '10.10.100.20',
            'port'      => '5432',
            'dbname'    => 'iipravaler',
            'user'      => 'iipravalersis',
            'password'  => '123456'
        )

    ),
    'comm' => array(


        'domains' => ['pravaler.com.br', 'idealinvest.com.br']
    ),
    'rabbitmq' => array(
        'ip' => '10.10.3.175',
        'port' => '5672',
        'user' => 'admin',
        'passwd' => 'admin'
    ),
    'mongoDB'        => array(
        'database'  => 'mongoDB',
        'driver'    => 'mongoDB',
        'host'      => '10.10.3.107',
        'port'      => '27017',
        'dbname'    => 'neo',
        'user'      => 'neo',
        'password'  => 'neo'
    )

);