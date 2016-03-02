app.controller 'RegisterDetailCtrl', [
  '$scope'
  '$state'
  '$ionicPopup'
  '$stateParams'
  'Register'
  ($scope, $state, $ionicPopup, $stateParams, Register) ->

    $scope.getRegister = ->
      Register.get
        id: $stateParams.registerId
      , (response) ->
        $scope.register = response
        $scope.register.date  = new Date($scope.register.date)

    $scope.deleteRegister = (id) ->
      confirmPopup = $ionicPopup.confirm
        title: 'Видалення'
        template: 'Ви впевнені в своєму рішенні?'
      confirmPopup.then (response) ->
        if response
          Register.delete
            id: id
          , ->
            $state.go 'admin.register'

    $scope.updateRegister = ->
      Register.update $scope.register
      , ->
        $state.go 'admin.register'

    init = ->
      $scope.getRegister()

    init()
]
