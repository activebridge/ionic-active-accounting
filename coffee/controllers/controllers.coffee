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

app.controller 'HoursCtrl', [
  '$scope'
  ($scope) ->
    console.log "I'm in hours controller"
]

app.controller 'CalcCtrl', [
  '$scope'
  ($scope) ->
    console.log "I'm in calc controller"
]

app.controller 'HolidaysCtrl', [
  '$scope'
  ($scope) ->
    console.log "I'm in holidays controller"
]

app.controller 'VendorPasswordResetCtrl', [
  '$scope'
  ($scope) ->
    console.log "I'm in vendor password reset controller"
]

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
