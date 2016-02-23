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
    url: '/vendor_profile/hours'
    views: 'hours-tab':
      templateUrl: 'templates/hours.html'
      controller: 'HoursCtrl'
  }
  .state 'vendor_profile.calc', {
    url: '/vendor_profile/calc'
    views: 'calc-tab':
      templateUrl: 'templates/calc.html'
      controller: 'CalcCtrl'
  }
  .state 'vendor_profile.holidays', {
    url: '/vendor_profile/our-holidays'
    views: 'holidays-tab':
      templateUrl: 'templates/holidays.html'
      controller: 'HolidaysCtrl'
  }
  .state 'vendor_password_reset', {
    url: 'vendor_password_reset/new'
    templateUrl: 'templates/vendor_password_reset.html'
    controller: 'VendorPasswordResetCtrl'
  }
