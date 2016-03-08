app.controller 'CounterpartyCtrl', [
  '$scope'
  'Counterparty'
  ($scope, Counterparty) ->

    $scope.counterparties = {}
    $scope.customers = {}
    $scope.vendors = {}
    $scope.others = {}
    $scope.HRs = {}

    $scope.loadCounterparties = ->
      # Need somehow to resolve requests overload here
      Counterparty.query (response) ->
        $scope.counterparties = response

      $scope.customers = Counterparty.query( group: 'Customer' )
      $scope.vendors = Counterparty.query( group: 'Vendor' )
      $scope.others = Counterparty.query( group: 'Other' )
      $scope.HRs = Counterparty.query( group: 'HR' )

    $scope.toggleGroup = (group) ->
      if $scope.isGroupShown(group)
        $scope.shownGroup = null
      else
        $scope.shownGroup = group

    $scope.isGroupShown = (group) ->
      $scope.shownGroup == group

    init = ->
      $scope.loadCounterparties()

    init()
]
