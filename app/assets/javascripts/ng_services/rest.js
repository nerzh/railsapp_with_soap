var app = angular.module('rest', ['ngResource']);

app.factory('restCountry', ['$resource', function($resource){
    return $resource('/countries/:id', {id: "@id"}, {
        update: {method:'PATCH'}
    });
}]);

app.factory('restTravel', ['$resource', function($resource){
    return $resource('/travels/:id', {id: "@id"}, {
        update: {method:'PATCH'}
    });
}]);