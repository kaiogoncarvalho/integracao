<?php

if (!defined('ENVIRONMENT')) {
    define('ENVIRONMENT', 'LO');
}

return array(

    'base_url'      => 'https://st.bpm.idealinvest.com.br',
    'product-front' => array('host' => 'http://st.product.idealinvest.com.br'),

    'api'           => array('host' => 'http://st.api.idealinvest.srv.br'),
    'assignment'    => array('host' => 'http://st.assignment.idealinvest.srv.br'),
    'bpm'           => array('host' => 'http://st.bpm.idealinvest.com.br'),
    'creditscore'   => array('host' => 'http://st.creditscore.idealinvest.srv.br'),
    'email'         => array('host' => 'http://st.email.idealinvest.srv.br'),
    'institution'   => array('host' => 'http://st.institution.idealinvest.srv.br'),
    'integration'   => array('host' => 'http://st.integration.idealinvest.srv.br'),
    'oauth'         => array('host' => 'http://st.oauth.idealinvest.srv.br',),
    'people'        => array('host' => 'http://st.people.idealinvest.srv.br'),
    'product'       => array('host' => 'http://st.product.idealinvest.srv.br'),
    'proposal'      => array('host' => 'http://st.proposal.idealinvest.srv.br'),
    'retornomec'    => array('host' => 'http://retornomec.idealinvest.srv.br'),
    'subscriptionfee'  => array('host' => 'http://st.fee.idealinvest.srv.br'),
    'spreadsheet'   => array('host' => 'http://st.spreadsheet.idealinvest.srv.br'),
    'student'       => array('host' => 'http://st.student.idealinvest.srv.br'),
    'backoffice'    => array('host' => 'http://backoffice.idealinvest.local'),

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
            'user'	=> 'iipravaler',
            'password'  => 'teste123'
        ),
        'neo'           => array(
            'database'  => 'pgsql',
            'driver'    => 'pdo_pgsql',
            'host'      => '10.10.3.107',
            'port'      => '5432',
            'dbname'    => 'pravaler',
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
        'invalido'        => array(
            'database'  => 'mysql',
            'driver'    => 'pdo_pgsql',
            'host'      => '10.10.3.107',
            'port'      => '3306',
            'dbname'    => 'db_errado',
            'user'      => 'para',
            'password'  => 'phpunit'
        )
    ),
    'mongoDB'        => array(
        'database'  => 'mongoDB',
        'driver'    => 'mongoDB',
        'host'      => '10.10.3.107',
        'port'      => '27017',
        'dbname'    => 'neo',
        'user'      => 'neo',
        'password'  => 'neo'
    ),
    'rabbitmq' => array(
        'ip' => '10.10.3.175',
        'port' => '5672',
        'user' => 'admin',
        'passwd' => 'admin'
    ),
    'smtp' => array(
        'host' => 'smtp.office365.com',
        'port' => '587',
        'user' => 'cadastro@pravaler.com.br',
        'password' => 'Vu0#EJ35M9',
    ),

    'comm' => array(
        'AWS_ACCESS_KEY_ID' => 'AKIAILJEMYWPDR4LHL3Q',
        'AWS_SECRET_ACCESS_KEY' => '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',
        'AWS_REGION' => 'us-east-1',
        'domains' => ['pravaler.com.br', 'idealinvest.com.br']
    ),

    'log' => array(
        'AWS_ACCESS_KEY_ID' => 'AKIAI5FI3JDFKNGCAIQA',
        'AWS_SECRET_ACCESS_KEY' => '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',
        'AWS_REGION' => 'sa-east-1',
        'VERSION' => '2012-08-10',
        'host' => 'http://st.log.idealinvest.srv.br'
    ),

    'admin' => array(
        ['name' => 'Andrey', 'email' => 'andrey.rocha@idealinvest.com.br'],
    ),

    'clients'     => [
        'neo' => [
            'secret' => 'abc',
            'name' => 'neo',
            'redirect_uri' => '',
            'is_confidential' => true,
        ],
        'clubedevantagens' => [
            'secret' => '123456',
            'name' => 'clubedevantagens',
            'redirect_uri' => '',
            'is_confidential' => true,
        ],
    ]
);