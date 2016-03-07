(function(){
    var thisController = function($scope, $rootScope, restCountry) {
        $scope.init = function (visit) {
            $scope.visited = visit;
            $scope.class = {};
            visit ? $scope.class.text = 'text-decor-line' : $scope.class.text = 'text-decor-none'
        };

        $scope.visitTrue = function (id) {
            restCountry.update(
                {id: id, country: {visited: true}},
                function (response) {
                    $scope.visited = true;
                    $scope.class =
                    {
                        text: 'text-decor-line'
                    };
                    $scope.setClass(response.ids);
                },
                function (error) {
                    alert("Sorry! Try later.\n\n" + error.statusText + "\n\nStatus:" + error.status);
                }
            );
        };

        $scope.visitFalse = function (id) {
            restCountry.update(
                {id: id, country: {visited: false}},
                function (response) {
                    $scope.visited = false;
                    $scope.class =
                    {
                        text: 'text-decor-none'
                    };
                    $scope.setName('text-decor-none');
                },
                function (error) {
                    alert("Sorry! Try later.\n\n" + error.statusText + "\n\nStatus:" + error.status);
                }
            );
        };
    };

    angular.module("mrSmart").directive("countryItem", function() {
        return {
            restrict: "A",
            scope: true,
            controller: ["$scope", "$rootScope", "restCountry", thisController]
        };
    });
}).call(this);