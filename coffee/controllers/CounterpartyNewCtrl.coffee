app.controller 'CounterpartyNewCtrl', [
  '$scope'
  '$state'
  'Counterparty'
  ($scope, $state, Counterparty) ->

    $scope.types = [
      'Customer',
      'Vendor',
      'Other',
      'HR'
    ]

    $scope.counterparty = {}

    $scope.saveCounterparty = ->
      Counterparty.save($scope.counterparty
      , ->
        $scope.counterparty.errors = {}
        $state.go 'admin.counterparty'
      )
]
