app.controller 'CounterpartyDetailCtrl', [
  '$scope'
  '$state'
  '$ionicPopup'
  '$stateParams'
  'Counterparty'
  ($scope, $state, $ionicPopup, $stateParams, Counterparty) ->

    $scope.types = [
      'Customer',
      'Vendor',
      'Other',
      'HR'
    ]

    $scope.getCounterparty = ->
      Counterparty.get
        id: $stateParams.counterpartyId
      , (response) ->
        $scope.counterparty = response
        $scope.counterparty.start_date = new Date($scope.counterparty.start_date)

    $scope.deleteCounterparty = (id) ->
      confirmPopup = $ionicPopup.confirm
        title: 'Видалення'
        template: 'Ви впевнені в своєму рішенні?'
      confirmPopup.then (response) ->
        if response
          Counterparty.delete
            id: id
          , ->
            $state.go 'admin.counterparty'

    $scope.updateCounterparty = ->
      Counterparty.update $scope.counterparty
      , ->
        $state.go 'admin.counterparty'

    init = ->
      $scope.getCounterparty()

    init()

]
