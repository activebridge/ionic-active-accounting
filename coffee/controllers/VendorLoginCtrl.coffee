app.controller 'VendorLoginCtrl', [
  '$scope'
  '$state'
  '$auth'
  '$ionicPopup'
  '$localStorage'
  ($scope, $state, $auth, $ionicPopup, $localStorage) ->

    $scope.redirectLoggedUser = ->
      if $localStorage.currentVendor
        $state.go 'vendor-profile.hours'
      if $localStorage.currentAdmin
        $state.go 'admin.register'

    $scope.submit = ->
      $auth.login($scope.vendor).then((response) ->
        $state.go 'vendor-profile.hours'
        $localStorage.currentVendor = response.data
      )['catch'] (error) ->
        alertPopup = $ionicPopup.alert(
          title: 'Login failed!'
          template: 'Please check your credentials!')

    init = ->
      $scope.vendor = {}
      $scope.redirectLoggedUser()

    init()
]
