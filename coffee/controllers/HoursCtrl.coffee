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
      $scope.workDays($scope.hour.month)
      $scope.vendor = $localStorage.currentVendor
      $scope.hour.customer_id = $scope.vendor.customer_id
      $scope.customers = Counterparty.customers(scope: 'active')
      $scope.hours = Hours.query(vendor_id: $scope.vendor.id)
      $scope.edit = false

    $scope.add = ->
      Hours.save $scope.hour,
        (hour) ->
          $scope.hours.push(hour)
          $scope.hour.errors = {}
        (response) ->
          $scope.hour.errors = response.data.error

    $scope.delete = (id, index) ->
      Hours.delete
        id: id
      , ->
        $scope.hours.splice(index,1)

    $scope.update = (hour_id, data) ->
      Hours.update(id: hour_id, { hour: { hours: data } }
        () ->
        (response) ->
      )

    $scope.workDays = (month) ->
      $scope.getWorkingDays(month)
      $scope.$watch 'workingDays', (value) ->
        $scope.hour.hours = $scope.getWorkingHours()

    init()
]
