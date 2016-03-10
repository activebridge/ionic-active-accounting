app.controller 'CounterpartyNewCtrl', [
  '$scope'
  '$state'
  'Counterparty'
  'counterpartyTypes'
  ($scope, $state, Counterparty, counterpartyTypes) ->

    $scope.saveCounterparty = ->
      Counterparty.save($scope.counterparty
      , ->
        $scope.counterparty.errors = {}
        $state.go 'admin.counterparty'
      )

    init = ->
      $scope.counterparty = {}
      $scope.types = counterpartyTypes
      $scope.getCounterparty()

    init()
]
