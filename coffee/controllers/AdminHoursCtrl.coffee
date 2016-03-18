app.controller 'AdminHoursCtrl', [
  '$scope'
  'Hours'
  'ReportHours'
  'Counterparty'
  '$localStorage'
  'hourDecorator'
  ($scope, Hours, ReportHours, Counterparty, $localStorage, hourDecorator) ->
    hourDecorator($scope)

    init = ->
      $scope.current = {}
      $scope.current.year = moment().format('YYYY')
      $scope.current.month = moment().format('M/YYYY')
      $scope.months = []
      count = 0
      for key in moment.months()
        count += 1
        $scope.months.push
          value: count + '/' + $scope.current.year
          text: key
      $scope.hour = {}
      $scope.hour.errors = {}
      $scope.hour.month = new Date()
      $scope.customers = Counterparty.customers(scope: 'active')
      $scope.vendors = Counterparty.query
        scope: 'active'
        group: 'Vendor'
      $scope.getHours($scope.current.month)
      $scope.workDays($scope.hour.month)

    $scope.add = ->
      ReportHours.save $scope.hour,
        (hour) ->
          $scope.hours.push(hour)
          $scope.hour.errors = {}
        (response) ->
          $scope.hour.errors = response.data.error

    $scope.getHours = (month) ->
      $scope.hours = Hours.query(month: month)

    init()
]
