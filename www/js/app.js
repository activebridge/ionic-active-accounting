var app;

app = angular.module('active-accounting', ['ionic', 'ngResource']).run(function($ionicPlatform) {
  return $ionicPlatform.ready(function() {
    if (window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      cordova.plugins.Keyboard.disableScroll(true);
    }
    if (window.StatusBar) {
      return StatusBar.styleDefault();
    }
  });
});

app.config(function($stateProvider, $urlRouterProvider) {
  $urlRouterProvider.otherwise('/login');
  return $stateProvider.state('login', {
    url: '/login',
    templateUrl: 'templates/login.html',
    controller: 'loginCtrl'
  });
});

app.controller('loginCtrl', [
  '$scope', 'Vendor', function($scope, Vendor) {
    $scope.vendor = {};
    return $scope.submit = function() {
      return Vendor.save($scope.vendor, function(response) {
        return console.log(response);
      });
    };
  }
]);

angular.module('active-accounting').factory('Vendor', [
  '$resource', function($resource) {
    return $resource('/api/vendor_login/:id.json', {
      id: '@id'
    }, {
      update: {
        method: 'PUT'
      }
    });
  }
]);


