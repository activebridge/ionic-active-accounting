app.factory 'toggleDecorator', [ ->
  ($scope) ->
    $scope.toggleGroup = (group) ->
      if $scope.isGroupShown(group)
        $scope.shownGroup = null
      else
        $scope.shownGroup = group

    $scope.isGroupShown = (group) ->
      $scope.shownGroup == group
]
