app.controller 'loginCtrl', [
  '$scope'
  'Vendor'
  ($scope, Vendor) ->
    Vendor.save()
]
