angular.module("mrSmart")
    .controller("rootCtrl", [ '$scope', '$rootScope', function ($scope, $rootScope) {
        $scope.init = function(show) {
            $scope.show_control = show;
        };
    }]);