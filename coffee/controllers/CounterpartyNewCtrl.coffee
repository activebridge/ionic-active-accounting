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

    $scope.isVendor = ->
      $scope.counterparty?.type == 'Vendor'

    $scope.hasEmail = ->
      $scope.counterparty?.type == 'Vendor' || $scope.counterparty?.type == 'HR'


    init = ->
      $scope.counterparty = {}
      $scope.types = counterpartyTypes
      $scope.activeCustomers = Counterparty.query
        scope: 'active'
        group: 'Customer'

    init()
]
