app.controller 'CounterpartyCtrl', [
  '$scope'
  'Counterparty'
  'toggleDecorator'
  ($scope, Counterparty, toggleDecorator) ->
    toggleDecorator($scope)

    $scope.loadCounterparties = ->
      Counterparty.query (response) ->
        $scope.counterparties = response

    init = ->
      $scope.customers = {}
      $scope.vendors = {}
      $scope.others = {}
      $scope.HRs = {}
      $scope.loadCounterparties()

    init()
]
