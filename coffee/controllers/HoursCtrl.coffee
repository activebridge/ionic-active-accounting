app.controller 'HoursCtrl', [
  '$scope'
  'Hours'
  'Counterparty'
  '$localStorage'
  'hourDecorator'
  ($scope, Hours, Counterparty, $localStorage, hourDecorator) ->
    hourDecorator($scope)

    init = ->
      $scope.hour = {}
      $scope.hour.errors = {}
      $scope.hour.month = new Date()
      $scope.customers = Counterparty.customers(scope: 'active')
      $scope.vendor = $localStorage.currentVendor
      $scope.hour.customer_id = $scope.vendor.customer_id
      $scope.hours = Hours.query(vendor_id: $scope.vendor.id)
      $scope.workDays($scope.hour.month)  

    $scope.add = ->
      Hours.save $scope.hour,
        (hour) ->
          $scope.hours.push(hour)
          $scope.hour.errors = {}
        (response) ->
          $scope.hour.errors = response.data.error

    init()
]
