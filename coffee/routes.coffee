app.config ($stateProvider, $urlRouterProvider, $ionicConfigProvider) ->

  $ionicConfigProvider.tabs.position 'bottom'
  $ionicConfigProvider.navBar.alignTitle 'center'

  $urlRouterProvider.otherwise '/vendor_login'

  $stateProvider.state 'vendor_login', {
    url: '/vendor_login'
    templateUrl: 'templates/vendor_login.html'
    controller: 'VendorLoginCtrl'
  }
  .state 'vendor_profile', {
    url: '/vendor_profile'
    abstract: true
    templateUrl: 'templates/vendor_profile.html'
    controller: 'VendorProfileCtrl'
  }
  .state 'vendor_profile.hours', {
    url: '/hours'
    views: 'hours-tab':
      templateUrl: 'templates/hours.html'
      controller: 'HoursCtrl'
    requireAuth: true
  }
  .state 'vendor_profile.calc', {
    url: '/calc'
    views: 'calc-tab':
      templateUrl: 'templates/calc.html'
      controller: 'CalcCtrl'
    requireAuth: true
  }
  .state 'vendor_profile.holidays', {
    url: '/our-holidays'
    views: 'holidays-tab':
      templateUrl: 'templates/holidays.html'
      controller: 'HolidaysCtrl'
    requireAuth: true
  }
  .state 'vendor_password_reset', {
    url: 'vendor_password_reset/new'
    templateUrl: 'templates/vendor_password_reset.html'
    controller: 'VendorPasswordResetCtrl'
  }
