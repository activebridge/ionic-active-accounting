app.config ($stateProvider, $urlRouterProvider, $ionicConfigProvider) ->

  vendorLoginRequired = ($q, $state, $auth) ->
    deferred = undefined
    deferred = $q.defer()
    if $auth.isAuthenticated()
      deferred.resolve()
    else
      $state.go 'vendor-login'
    deferred.promise

  adminLoginRequired = ($q, $state, $localStorage) ->
    deferred = undefined
    deferred = $q.defer()
    if angular.isObject($localStorage.currentAdmin)
      deferred.resolve()
    else
      $state.go 'admin-login'
    deferred.promise

  $ionicConfigProvider.tabs.position 'bottom'
  $ionicConfigProvider.navBar.alignTitle 'center'

  $urlRouterProvider.otherwise '/vendor_login'

  $stateProvider.state 'vendor-login', {
    url: '/vendor_login'
    templateUrl: 'templates/vendor_login.html'
    controller: 'VendorLoginCtrl'
  }
  .state 'vendor-profile', {
    url: '/vendor_profile'
    abstract: true
    templateUrl: 'templates/vendor_profile.html'
    controller: 'VendorProfileCtrl'
  }
  .state 'vendor-profile.hours', {
    url: '/hours'
    views: 'hours-tab':
      templateUrl: 'templates/hours.html'
      controller: 'HoursCtrl'
    resolve:
      loginRequired: vendorLoginRequired
    cache: false
  }
  .state 'vendor-profile.calc', {
    url: '/calc'
    views: 'calc-tab':
      templateUrl: 'templates/calc.html'
      controller: 'CalcCtrl'
    resolve:
      loginRequired: vendorLoginRequired
    cache: false
  }
  .state 'vendor-profile.holidays', {
    url: '/our-holidays'
    views: 'holidays-tab':
      templateUrl: 'templates/holidays.html'
      controller: 'HolidaysCtrl'
    resolve:
      loginRequired: vendorLoginRequired
    cache: false
  }
  .state 'vendor-password-reset', {
    url: 'vendor_password_reset/new'
    templateUrl: 'templates/vendor_password_reset.html'
    controller: 'VendorPasswordResetCtrl'
  }
  .state 'admin-login', {
    url: '/admin_login'
    templateUrl: 'templates/admin_login.html'
    controller: 'AdminLoginCtrl'
  }
  .state 'admin', {
    url: '/admin'
    abstract: true
    templateUrl: 'templates/admin.html'
    controller: 'AdminCtrl'
  }
  .state 'admin.register', {
    url: '/register'
    cache: false
    views: 'register-tab':
      templateUrl: 'templates/register.html'
      controller: 'RegisterCtrl'
    resolve:
      loginRequired: adminLoginRequired
  }
  .state 'admin.register-new', {
    url: '/register/new'
    views: 'register-tab':
      templateUrl: 'templates/register-new.html'
      controller: 'RegisterNewCtrl'
    resolve:
      loginRequired: adminLoginRequired
  }
  .state 'admin.register-detail', {
    url: '/register/:registerId'
    views: 'register-tab':
      templateUrl: 'templates/register-detail.html'
      controller: 'RegisterDetailCtrl'
    resolve:
      loginRequired: adminLoginRequired
  }
  .state 'admin.counterparty', {
    url: '/counterparty'
    cache: false
    views: 'counterparty-tab':
      templateUrl: 'templates/counterparty.html'
      controller: 'CounterpartyCtrl'
    resolve:
      loginRequired: adminLoginRequired
  }
  .state 'admin.counterparty-new', {
    url: '/counterparty/new'
    cache: false
    views: 'counterparty-tab':
      templateUrl: 'templates/counterparty-new.html'
      controller: 'CounterpartyNewCtrl'
    resolve:
      loginRequired: adminLoginRequired
  }
