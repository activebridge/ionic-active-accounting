var app;

app = angular.module('active-accounting', ['ionic', 'ngResource', 'satellizer', 'Devise']).run(function($ionicPlatform) {
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

app.run(function($rootScope, $auth, $state) {
  return $rootScope.$on('$stateChangeStart', function(event, toState) {
    if (toState.requireAuth && !$auth.isAuthenticated()) {
      event.preventDefault();
      return $state.go('vendor_login');
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
    templateUrl: 'templates/vendor_profile.html',
    controller: 'VendorProfileCtrl'
  }).state('vendor_profile.hours', {
    url: '/hours',
    views: {
      'hours-tab': {
        templateUrl: 'templates/hours.html',
        controller: 'HoursCtrl'
      }
    },
    requireAuth: true
  }).state('vendor_profile.calc', {
    url: '/calc',
    views: {
      'calc-tab': {
        templateUrl: 'templates/calc.html',
        controller: 'CalcCtrl'
      }
    },
    requireAuth: true
  }).state('vendor_profile.holidays', {
    url: '/our-holidays',
    views: {
      'holidays-tab': {
        templateUrl: 'templates/holidays.html',
        controller: 'HolidaysCtrl'
      }
    },
    requireAuth: true
  }).state('vendor_password_reset', {
    url: 'vendor_password_reset/new',
    templateUrl: 'templates/vendor_password_reset.html',
    controller: 'VendorPasswordResetCtrl'
  }).state('admin_login', {
    url: '/admin_login',
    templateUrl: 'templates/admin_login.html',
    controller: 'AdminLoginCtrl'
  }).state('admin', {
    url: '/admin',
    abstract: true,
    templateUrl: 'templates/admin.html',
    controller: 'AdminCtrl'
  }).state('admin.home', {
    url: '/home',
    views: {
      'home-tab': {
        templateUrl: 'templates/home.html',
        controller: 'HomeCtrl'
      }
    }
  });
});

app.constant('apiEndpoint', 'http://localhost:3000');

app.config([
  '$authProvider', '$httpProvider', 'apiEndpoint', function($authProvider, $httpProvider, apiEndpoint) {
    $authProvider.withCredentials = true;
    $authProvider.httpInterceptor = true;
    $authProvider.baseUrl = apiEndpoint;
    $authProvider.loginUrl = '/vendor_login.json';
    $authProvider.tokenName = 'auth_token';
    $authProvider.tokenPrefix = 'satellizer';
    $authProvider.authHeader = 'Authorization';
    $authProvider.authToken = 'Bearer';
    return $authProvider.cordova = true;
  }
]);

app.controller('VendorLoginCtrl', [
  '$scope', '$state', '$auth', '$ionicPopup', function($scope, $state, $auth, $ionicPopup) {
    $scope.vendor = {};
    return $scope.submit = function() {
      return $auth.login($scope.vendor).then(function(response) {
        return $state.go('vendor_profile.hours');
      })['catch'](function(error) {
        var alertPopup;
        return alertPopup = $ionicPopup.alert({
          title: 'Login failed!',
          template: 'Please check your credentials!'
        });
      });
    };
  }
]);

app.controller('AdminLoginCtrl', ['$scope', '$state', '$ionicPopup', function($scope, $state, $ionicPopup) {}]);

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

app.controller('VendorProfileCtrl', [
  '$scope', '$state', '$auth', '$ionicPopup', function($scope, $state, $auth, $ionicPopup) {
    $scope.isAuthenticated = function() {
      return $auth.isAuthenticated();
    };
    return $scope.logout = function() {
      return $auth.logout().then(function() {
        return $state.go('vendor_login');
      });
    };
  }
]);


