app.controller 'HolidaysCtrl', [
  '$scope'
  'Holiday'
  ($scope, Holiday) ->
    init = ->
      $scope.current = {}
      $scope.current.year = moment().format('YYYY')
      $scope.holiday = {}
      $scope.holiday.errors = {}
      $scope.holidays = Holiday.query(year: $scope.current.year)
      getCorrectDate()
      $scope.years = [2015..parseInt($scope.current.year, 10) + 1]

    getCorrectDate = ->
      $scope.holidays.$promise.then ->
        for key in $scope.holidays
          key.date = new Date(key.date.substr(3, 3) + key.date.substr(0, 2) + key.date.substr(5, 5))

    $scope.delete = (id, index) ->
      Holiday.delete
        id: id
      , (success) ->
        $scope.holidays.splice(index,1)

    $scope.update = (id, data) ->
      date = data.date.getDate() + "." + (data.date.getMonth() + 1) + "." + data.date.getFullYear()
      Holiday.update(id: id, { holiday: { name: data.name, date: date } })

    $scope.changeYear = ->
      $scope.holidays = Holiday.query(year: $scope.current.year)
      getCorrectDate()

    init()
]
