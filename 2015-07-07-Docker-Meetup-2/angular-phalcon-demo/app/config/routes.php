<?php
$configuration = [
    'index' => [
        'setHandler' => '\Demo\Controller\Util\IndexCtrl',
        'routes' => [
            'get' => [
                '/' => 'index'
            ],
            'options' => [
                '/{catch:(.*)}' => 'options'
            ]
        ]
    ]
];

return $configuration;
