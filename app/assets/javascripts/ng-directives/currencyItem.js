(function(){
    angular.module("mrSmart").directive("currencyItem", function() {
        return {
            restrict: "A",
            scope: true,
            controller: ["$scope", "$rootScope", "restCountry", thisController]
        };
    });

    var thisController = function ($scope, $rootScope) {
        $scope.init = function(visit, id) {
            $scope.id = id;
            $scope.visited = visit;
            $scope.class = {};
            visit ? $scope.class.text = 'text-decor-line' : $scope.class.text = 'text-decor-none'
        };

        $scope.setClass = function(array){
            for (var i = 0; i < array; i++) {
                if ($scope.id == array[i]) {
                    $scope.class.text = 'text-decor-line';
                }
            }
        };

        $scope.setName = function(name){
            $scope.class.text = name;
        };
    };
}).call(this);