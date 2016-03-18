app.factory 'hourDecorator', ['Hours', 'WorkDay', (Hours, WorkDay) ->
  ($scope) ->

    $scope.getWorkingDays = (value) ->
      WorkDay.get
        date: value,
        (response) ->
          $scope.workingDays = response.count

    $scope.getWorkingHours = ->
      $scope.workingHours = $scope.workingDays * 8

    $scope.workDays = (month) ->
      $scope.getWorkingDays(month)
      $scope.$watch 'workingDays', (value) ->
        $scope.hour.hours = $scope.getWorkingHours()

    $scope.delete = (id, index) ->
      Hours.delete
        id: id
      , ->
        $scope.hours.splice(index,1)

    $scope.update = (id, data) ->
      Hours.update id: id, hour: hours: data
      , ->
      (response) ->

]
