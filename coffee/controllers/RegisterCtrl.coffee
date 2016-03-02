app.controller 'RegisterCtrl', [
  '$scope'
  '$state'
  'Register'
  ($scope, $state, Register) ->

    $scope.loadRegisters = ->
      Register.query (response) ->
        $scope.registers = response

    init = ->
      $scope.loadRegisters()

    init()
]
