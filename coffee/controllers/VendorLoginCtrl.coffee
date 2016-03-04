app.controller 'VendorLoginCtrl', [
  '$scope'
  '$state'
  '$auth'
  '$ionicPopup'
  '$localStorage'
  ($scope, $state, $auth, $ionicPopup, $localStorage) ->

    $scope.vendor = {}

    $scope.submit = ->
      $auth.login($scope.vendor).then((response) ->
        $state.go 'vendor_profile.hours'
        $localStorage.currentVendor = response.data
      )['catch'] (error) ->
        alertPopup = $ionicPopup.alert(
          title: 'Login failed!'
          template: 'Please check your credentials!')
]
