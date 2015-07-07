(function (angular, _) {
    'use strict';

    angular.module('Demo').controller('Demo.LayoutCtrl', DemoCtrl);

    /* @ngInject */
    function DemoCtrl () {
        var vm = this;
        vm.hello = 'I like oranges!';
    }
})(window.angular, window._);
