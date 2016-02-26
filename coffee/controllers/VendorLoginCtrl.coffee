app.controller 'VendorLoginCtrl', [
  '$scope'
  '$state'
  '$auth'
  '$ionicPopup'
  ($scope, $state, $auth, $ionicPopup) ->

    $scope.vendor = {}

    $scope.submit = ->
      $auth.login($scope.vendor).then((response) ->
        $state.go 'vendor_profile.hours'
      )['catch'] (error) ->
        alertPopup = $ionicPopup.alert(
          title: 'Login failed!'
          template: 'Please check your credentials!')
]
