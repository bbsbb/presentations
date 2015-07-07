;(function (angular, _) {
    'use strict';

    // Setup application routing
    angular.module(
        'Demo',
        [
            'ui.router',
            'Demo.Partials'
        ]
    )
        .config(routeConfig);

    /* @ngInject */
    function routeConfig($locationProvider, $urlRouterProvider, $stateProvider) {
        $urlRouterProvider.when('', '/');
        $urlRouterProvider.otherwise('/not-found');

        $stateProvider
            .state(
                'demo',
                {
                    'url': '/',
                    'templateUrl': 'layout/views/index.html',
                    'controller': 'Demo.LayoutCtrl',
                    'controllerAs': 'demo'
                }
            )
            .state(
                'not-found',
                {
                    url: '/not-found'
                }
            );
        // If none of the states are matched go to 404 page
        $locationProvider.html5Mode(true);
   }

    // Register angular application & dependencies
    angular.module('Demo').run();
})(window.angular, window._);
