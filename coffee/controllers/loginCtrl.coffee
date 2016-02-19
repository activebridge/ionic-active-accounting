app.controller 'loginCtrl', [
  '$scope'
  'Vendor'
  ($scope, Vendor) ->
    $scope.vendor = {}
#
    $scope.submit = ->
      Vendor.save($scope.vendor,
        (response)->
          console.log response
      )
]
