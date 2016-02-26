app.controller 'HoursCtrl', ['$scope', 'Hours', 'Counterparty', '$localStorage', ($scope, Hours, Counterparty, $localStorage) ->
  $scope.hour = {}
  $scope.hour.errors = {}
  $scope.customers = Counterparty.customers(scope: 'active')

  init = ->
    $scope.vendor = $localStorage.currentVendor
    $scope.hours = Hours.query(vendor_id: $scope.vendor.id)

  $scope.add = ->
    hour = Hours.save($scope.hour,
      () ->
        $scope.hours.push(hour)
        $scope.hour.errors = []
      (response) ->
        $scope.hour.errors = response.data.error
    )

  init()
]
