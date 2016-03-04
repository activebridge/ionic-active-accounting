app.controller 'VendorProfileCtrl', [
  '$scope'
  '$state'
  '$auth'
  '$ionicPopup'
  '$localStorage'
  ($scope, $state, $auth, $ionicPopup, $localStorage) ->

    $scope.isAuthenticated = ->
      $auth.isAuthenticated()

    $scope.logout = ->
      $auth.logout().then ->
        $state.go 'vendor_login'
        $localStorage.currentVendor = null

]
