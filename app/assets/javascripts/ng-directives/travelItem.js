(function(){
    var thisController = function ($scope, $rootScope, restTravel) {
        $scope.init = function(complete) {
            $scope.complete = complete;
        };

        $scope.completed = function (id) {
            restTravel.update(
                {id: id, travel: {complete_date: new Date()}},
                function (response) {
                    $scope.complete = true;
                },
                function (error) {
                    alert("Sorry! Try later.\n\n" + error.statusText + "\n\nStatus:" + error.status);
                }
            );
        };

        $scope.uncompleted = function (id) {
            restTravel.update(
                {id: id, travel: {complete_date: ''}},
                function (response) {
                    $scope.complete = false;
                },
                function (error) {
                    alert("Sorry! Try later.\n\n" + error.statusText + "\n\nStatus:" + error.status);
                }
            );
        };
    };

    angular.module("mrSmart").directive("travelItem", function() {
        return {
            restrict: "A",
            scope: true,
            controller: ["$scope", "$rootScope", "restTravel", thisController]
        };
    });
}).call(this);