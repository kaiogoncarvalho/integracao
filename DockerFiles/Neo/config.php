<?php

if (!defined('ENVIRONMENT')) {
    define('ENVIRONMENT', 'lo');
}

return array(

    'base_url'        => 'http://st.bpm.idealinvest.com.br',
    'product-front'   => array('host' => 'http://st.product.idealinvest.com.br'),
    'backoffice'      => array(
        'host'  => 'http://backoffice.pravaler.rf',
        'token-proposta' => '539a6c1ee350a8c21d56b68719a01caf'
    ),
    'api'             => array('host' => 'http://st.import.proposal.idealinvest.srv.br'),
    'assignment'      => array('host' => 'http://st.assignment.idealinvest.srv.br'),
    'bpm'             => array('host' => 'http://st.bpm.idealinvest.srv.br'),
    'creditscore'     => array('host' => 'http://st.creditscore.idealinvest.srv.br'),
    'email'           => array('host' => 'http://st.email.idealinvest.srv.br'),
    'fee'             => array('host' => 'http://st.fee.idealinvest.srv.br'),
    'institution'     => array('host' => 'http://st.institution.idealinvest.srv.br'),
    'negotiation'     => array('host' => 'http://st.negotiation.idealinvest.srv.br'),
    'integration'     => array('host' => 'http://st.integration.idealinvest.srv.br'),
    'people'          => array('host' => 'http://st.people.idealinvest.srv.br'),
    'product'         => array('host' => 'http://st.product.idealinvest.srv.br'),
    'proposal'        => array('host' => 'http://st.proposal.idealinvest.srv.br'),
    'proposal-v2'     => array(
        'host'        => 'http://st.v2.proposal.idealinvest.srv.br',
        'fies'        => array(
            'paths'    => array(
                'toProcess'        => '/opt/neo/fies/to_process/',
                'processed'        => '/opt/neo/fies/processed/',
                'processedSuccess' => '/opt/neo/fies/processed_success/',
                'processedFail'    => '/opt/neo/fies/processed_fail/',
                'fiesstg'                => '/opt/neo/fies/stg/',

                'processedScoreSuccess'  => '/opt/neo/fies/processed_score_success/',
                'processedScoreFail'     => '/opt/neo/fies/processed_score_fail/',
                'processedScoreFailRequest'     => '/opt/neo/fies/processed_score_fail_request/',
                'processedScoreRequestResult' => '/opt/neo/fies/processed_score_request_result/',

                'processedAlstcationSuccess' => '/opt/neo/fies/processed_alstcation_success/',
                'processedAlstcationFail' => '/opt/neo/fies/processed_alstcation_fail/',
                'processedAlstcationFailRequest' => '/opt/neo/fies/processed_alstcation_fail_request/',
                'processedAlstcationRequestResult' => '/opt/neo/fies/processed_alstcation_request_result/',

                'processedAutoApprovalSuccess' => '/opt/neo/fies/processed_autoapproval_success/',
                'processedAutoApprovalFail' => '/opt/neo/fies/processed_autoapproval_fail/',
                'processedAutoApprovalFailRequest' => '/opt/neo/fies/processed_autoapproval_fail_request/',
                'processedAutoApprovalRequestResult' => '/opt/neo/fies/processed_autoapproval_request_result/',

                'processedAnalysisReturnRequestResult' => '/opt/neo/fies/processed_analysisreturn_request_result/',

                'failInformed'     => '/opt/neo/fies/fail_informed/',
                'reprocess'        => '/opt/neo/fies/stg/reprocess/',
                'proposalActive'        => '/opt/neo/fies/proposal_active/',
                'courseNotFound'        => '/opt/neo/fies/course_not_found/',

                'mecProcessedSuccess' => '/opt/neo/mec/processed_success/',
                'mecProcessedFail' => '/opt/neo/mec/processed_fail/',
                'mecToProcess' => '/opt/neo/mec/to_process/'
            ),
            'reprocess' => array(
                'queueName' => 'hmg-reanalise-creditscore'
            )
        ),
        'amazon' => array(
            'sqs' => array(
                'AWS_ACCESS_KEY_ID' => 'AKIAI5FI3JDFKNGCAIQA',
                'AWS_SECRET_ACCESS_KEY' => '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',
                'AWS_REGION' => 'sa-east-1'
            ),

        )
    ),
    'retornomec'      => array('host' => 'http://st.retornomec.idealinvest.srv.br'),
    'student'         => array('host' => 'http://st.student.idealinvest.srv.br'),
    'spreadsheet'     => array('host' => 'http://st.spreadsheet.idealinvest.srv.br'),
    'subscriptionfee' => array('host' => 'http://st.fee.idealinvest.srv.br'),

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
            'user'      => 'iipravalersis',
            'password'  => 'teste123'
        ),
        'replica'    => array(
            'database'  => 'pgsql',
            'driver'    => 'pdo_pgsql',
            'host'      => '10.10.100.20',
            'port'      => '5432',
            'dbname'    => 'iipravaler',
            'user'      => 'iipravalersis',
            'password'  => '123456'
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
        'oauth'           => array(
            'database'  => 'pgsql',
            'driver'    => 'pdo_pgsql',
            'host'      => '10.10.3.107',
            'port'      => '5432',
            'dbname'    => 'pravaler',
            'user'      => 'oauth2',
            'password'  => 'oauth2'
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
    ),

    // PRAVALER
    'comm' => array(
        'AWS_ACCESS_KEY_ID' => 'AKIAILJEMYWPDR4LHL3Q',
        'AWS_SECRET_ACCESS_KEY' => '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',
        'AWS_REGION' => 'us-east-1',
        'domains' => ['pravaler.com.br', 'idealinvest.com.br']
    ),

    // PRAVALER
    'log' => array(
        'AWS_ACCESS_KEY_ID' => 'AKIAI5FI3JDFKNGCAIQA',
        'AWS_SECRET_ACCESS_KEY' => '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',
        'AWS_REGION' => 'sa-east-1',
        'VERSION' => '2012-08-10',
        'host' => 'http://st.log.idealinvest.srv.br'
    ),

    // PRAVALER
    'log-v2' => array(
        'AWS_ACCESS_KEY_ID' => 'AKIAI5FI3JDFKNGCAIQA',
        'AWS_SECRET_ACCESS_KEY' => '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',
        'AWS_REGION' => 'sa-east-1',
        'VERSION' => '2012-08-10',
        'host' => 'http://st.v2.log.idealinvest.srv.br'
    ),

    'oauth'  => array(
        'host' => 'http://st.oauth.idealinvest.srv.br',
        'users' => array('backoffice.contrato', 'kroton.kroton', 'bv.bv')
    ),

    'amazon' => [
        'aws_key' => 'AKIAI5FI3JDFKNGCAIQA',
        'aws_secret' => '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',
        'aws_region' => 'sa-east-1',
        'aws_version' => 'latest'
    ],

    'admin' => array(
        ['name' => 'Andrey', 'email' => 'andrey.rocha@idealinvest.com.br']
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
