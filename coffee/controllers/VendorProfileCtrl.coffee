app.controller 'VendorProfileCtrl', [
  '$scope'
  '$state'
  '$auth'
  '$ionicPopup'
  ($scope, $state, $auth, $ionicPopup) ->

    $scope.isAuthenticated = ->
      $auth.isAuthenticated()

    $scope.logout = ->
      $auth.logout().then ->
        $state.go 'vendor_login'
]
