app.factory 'hourDecorator', ['Hours', 'WorkDay', (Hours, WorkDay) ->
  ($scope) ->
    $scope.getWorkingDays = (value) ->
      WorkDay.get
        date: value,
        (response) ->
          $scope.workingDays = response.count

    $scope.getWorkingHours = ->
      $scope.workingHours = $scope.workingDays * 8
]
