app.controller 'CounterpartyCtrl', [
  '$scope'
  'Counterparty'
  ($scope, Counterparty) ->

    $scope.loadCounterparties = ->
      Counterparty.query (response) ->
        $scope.counterparties = response

    init = ->
      $scope.loadCounterparties()

    init()
]
