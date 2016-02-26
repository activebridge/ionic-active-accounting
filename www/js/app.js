var app;

app = angular.module('active-accounting', ['ionic', 'ngResource', 'satellizer', 'Devise', 'ngStorage']).run(function($ionicPlatform) {
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
  var adminLoginRequired, vendorLoginRequired;
  vendorLoginRequired = function($q, $state, $auth) {
    var deferred;
    deferred = void 0;
    deferred = $q.defer();
    if ($auth.isAuthenticated()) {
      deferred.resolve();
    } else {
      $state.go('vendor_login');
    }
    return deferred.promise;
  };
  adminLoginRequired = function($q, $state, $localStorage) {
    var deferred;
    deferred = void 0;
    deferred = $q.defer();
    if (angular.isObject($localStorage.currentAdmin)) {
      deferred.resolve();
    } else {
      $state.go('admin_login');
    }
    return deferred.promise;
  };
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
    resolve: {
      loginRequired: vendorLoginRequired
    }
  }).state('vendor_profile.calc', {
    url: '/calc',
    views: {
      'calc-tab': {
        templateUrl: 'templates/calc.html',
        controller: 'CalcCtrl'
      }
    },
    resolve: {
      loginRequired: vendorLoginRequired
    }
  }).state('vendor_profile.holidays', {
    url: '/our-holidays',
    views: {
      'holidays-tab': {
        templateUrl: 'templates/holidays.html',
        controller: 'HolidaysCtrl'
      }
    },
    resolve: {
      loginRequired: vendorLoginRequired
    }
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
  }).state('admin.register', {
    url: '/register',
    views: {
      'register-tab': {
        templateUrl: 'templates/register.html',
        controller: 'RegisterCtrl'
      }
    },
    resolve: {
      loginRequired: adminLoginRequired
    }
  });
});

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

app.config([
  'AuthProvider', 'apiEndpoint', function(AuthProvider, apiEndpoint) {
    AuthProvider.loginPath(apiEndpoint + '/admins/sign_in.json');
    AuthProvider.logoutPath(apiEndpoint + '/admins/sign_out.json');
    return AuthProvider.resourceName('admin');
  }
]);

app.constant('apiEndpoint', 'http://localhost:3000');

app.controller('AdminCtrl', [
  '$scope', '$state', 'Auth', '$localStorage', function($scope, $state, Auth, $localStorage) {
    $scope.isCurrentAdmin = angular.isObject($localStorage.currentAdmin);
    return $scope.logout = function() {
      var config;
      config = {
        headers: {
          'X-HTTP-Method-Override': 'DELETE'
        }
      };
      return Auth.logout(config).then((function(oldUser) {
        $localStorage.currentAdmin = null;
        return $state.go('admin_login');
      }), function(error) {});
    };
  }
]);

app.controller('AdminLoginCtrl', [
  '$scope', '$state', 'Auth', '$ionicPopup', '$localStorage', function($scope, $state, Auth, $ionicPopup, $localStorage) {
    $scope.admin = {};
    return $scope.submit = function() {
      var config;
      config = {
        headers: {
          'X-HTTP-Method-Override': 'POST'
        }
      };
      return Auth.login($scope.admin, config).then((function(response) {
        $localStorage.currentAdmin = response;
        return $state.go('admin.register');
      }), function(error) {
        var alertPopup;
        return alertPopup = $ionicPopup.alert({
          title: 'Login failed!',
          template: 'Please check your credentials!'
        });
      });
    };
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

app.controller('HoursCtrl', [
  '$scope', function($scope) {
    return console.log("I'm in hours controller");
  }
]);

app.controller('RegisterCtrl', ['$scope', function($scope) {}]);

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


