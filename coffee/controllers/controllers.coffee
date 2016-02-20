app.controller 'loginCtrl', [
  '$scope'
  '$state'
  'Vendor'
  ($scope, $state, Vendor) ->
    $scope.vendor = {}
#
    $scope.submit = ->
      Vendor.save $scope.vendor
      $state.go 'vendor_profile.hours'
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
