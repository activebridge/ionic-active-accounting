app.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/login'

  $stateProvider.state 'login', {
    url: '/login'
    templateUrl: 'templates/login.html',
    controller: 'loginCtrl'
  }
