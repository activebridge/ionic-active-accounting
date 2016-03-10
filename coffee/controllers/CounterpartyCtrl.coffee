app.controller 'CounterpartyCtrl', [
  '$scope'
  'Counterparty'
  ($scope, Counterparty) ->

    $scope.loadCounterparties = ->
      Counterparty.query (response) ->
        $scope.counterparties = response

    $scope.toggleGroup = (group) ->
      if $scope.isGroupShown(group)
        $scope.shownGroup = null
      else
        $scope.shownGroup = group

    $scope.isGroupShown = (group) ->
      $scope.shownGroup == group

    init = ->
      $scope.customers = {}
      $scope.vendors = {}
      $scope.others = {}
      $scope.HRs = {}
      $scope.loadCounterparties()

    init()
]
