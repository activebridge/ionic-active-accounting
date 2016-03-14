app.controller 'HolidaysNewCtrl', [
  '$scope'
  '$state'
  'Holiday'
  ($scope, $state, Holiday) ->
    init = ->
      $scope.holiday = {}
      $scope.holiday.errors = {}
      $scope.holiday.date = new Date()
      
    $scope.add = ->
      Holiday.save $scope.holiday,
        (holiday) ->
          $scope.holiday.errors = {}
          $state.go 'admin.holidays'
        , (response) ->
          $scope.holiday.errors = response.data.error

    init()
]
