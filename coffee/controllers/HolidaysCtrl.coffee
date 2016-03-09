app.controller 'HolidaysCtrl', [
  '$scope'
  'Holiday'
  ($scope, Holiday) ->
    init = ->
      $scope.holiday = {}
      $scope.holiday.errors = {}
      $scope.currentYear = moment().format('YYYY')
      $scope.holidays = Holiday.query(year: $scope.currentYear)

    init()
]
