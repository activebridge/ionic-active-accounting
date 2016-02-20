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

app.config(function($stateProvider, $urlRouterProvider, $ionicConfigProvider) {
  $ionicConfigProvider.tabs.position('bottom');
  $ionicConfigProvider.navBar.alignTitle('center');
  $urlRouterProvider.otherwise('/vendor_login');
  return $stateProvider.state('vendor_login', {
    url: '/vendor_login',
    templateUrl: 'templates/vendor_login.html',
    controller: 'VendorLoginCtrl'
  }).state('vendor_profile', {
    url: '/vendor_profile',
    abstract: true,
    templateUrl: 'templates/vendor_profile.html'
  }).state('vendor_profile.hours', {
    url: '/vendor_profile/hours',
    views: {
      'hours-tab': {
        templateUrl: 'templates/hours.html',
        controller: 'HoursCtrl'
      }
    }
  }).state('vendor_profile.calc', {
    url: '/vendor_profile/calc',
    views: {
      'calc-tab': {
        templateUrl: 'templates/calc.html',
        controller: 'CalcCtrl'
      }
    }
  }).state('vendor_profile.holidays', {
    url: '/vendor_profile/our-holidays',
    views: {
      'holidays-tab': {
        templateUrl: 'templates/holidays.html',
        controller: 'HolidaysCtrl'
      }
    }
  }).state('vendor_password_reset', {
    url: 'vendor_password_reset/new',
    templateUrl: 'templates/vendor_password_reset.html',
    controller: 'VendorPasswordResetCtrl'
  });
});

app.controller('VendorLoginCtrl', [
  '$scope', '$state', 'Vendor', function($scope, $state, Vendor) {
    $scope.vendor = {};
    return $scope.submit = function() {
      Vendor.save($scope.vendor);
      return $state.go('vendor_profile.hours');
    };
  }
]);

app.controller('HoursCtrl', [
  '$scope', function($scope) {
    return console.log("I'm in hours controller");
  }
]);

app.controller('CalcCtrl', [
  '$scope', function($scope) {
    return console.log("I'm in calc controller");
  }
]);

app.controller('HolidaysCtrl', [
  '$scope', function($scope) {
    return console.log("I'm in holidays controller");
  }
]);

app.controller('VendorPasswordResetCtrl', [
  '$scope', function($scope) {
    return console.log("I'm in vendor password reset controller");
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


