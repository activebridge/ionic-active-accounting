app.controller 'RegisterNewCtrl', [
  '$scope'
  '$state'
  'Register'
  ($scope, $state, Register) ->

    $scope.register = {
      currency: 'UAH'
    }

    $scope.saveRegister = ->
      Register.save($scope.register
      , ->
        $scope.register.errors = {}
        $state.go 'admin.register'
      )
]
