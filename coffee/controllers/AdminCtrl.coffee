app.controller 'AdminCtrl', [
  '$scope'
  '$state'
  'Auth'
  '$localStorage'
  ($scope, $state, Auth, $localStorage) ->

    $scope.isCurrentAdmin = angular.isObject($localStorage.currentAdmin)

    $scope.logout = ->
      config = headers: 'X-HTTP-Method-Override': 'DELETE'

      Auth.logout(config).then ((oldUser) ->
        $localStorage.currentAdmin = null;
        $state.go 'admin_login'
      ), (error) ->
]
