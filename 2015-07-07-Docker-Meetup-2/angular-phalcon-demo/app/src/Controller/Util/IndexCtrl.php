<?php

namespace Demo\Controller\Util;

/**
 * @acl access whitelist
 **/
class IndexCtrl extends \Phalcon\Mvc\Controller
{
    public function index()
    {
        return ['status' => 'up'];
    }

    public function notFound()
    {
        return ['status' => 'not found'];
    }
}