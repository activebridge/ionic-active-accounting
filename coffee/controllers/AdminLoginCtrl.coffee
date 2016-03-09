app.controller 'AdminLoginCtrl', [
  '$scope'
  '$state'
  'Auth'
  '$ionicPopup'
  '$localStorage'
  ($scope, $state, Auth, $ionicPopup, $localStorage) ->

    $scope.admin = {}

    $scope.submit = ->
      config = headers: 'X-HTTP-Method-Override': 'POST'

      Auth.login($scope.admin, config).then ((response) ->
        $localStorage.currentAdmin = response
        $state.go 'admin.register'
      ), (error) ->
        alertPopup = $ionicPopup.alert(
          title: 'Login failed!'
          template: 'Please check your credentials!'
        )
]
