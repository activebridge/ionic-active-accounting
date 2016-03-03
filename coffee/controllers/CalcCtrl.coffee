app.controller 'CalcCtrl', ['$scope', 'Tax', ($scope, Tax) ->
  init = ->
    $scope.data = {}
    $scope.data.salary = 0
    $scope.data.exchange = 0
    $scope.data.translation = 0

    Tax.edit((response) ->
      $scope.tax = response
    )

  percentToIndex = (tax) ->
    1 - tax/100

  $scope.report = () ->
    $scope.salaryHrn = $scope.data.salary * $scope.data.exchange
    salaryAndTranslation = $scope.salaryHrn + $scope.data.translation
    salaryWithCashTax = salaryAndTranslation / percentToIndex($scope.tax.cash)
    $scope.cashingTaxSum = salaryWithCashTax - salaryAndTranslation
    $scope.singleTaxSum = salaryWithCashTax/percentToIndex($scope.tax.single) - salaryWithCashTax
    total = salaryWithCashTax + $scope.tax.social + $scope.singleTaxSum
    $scope.total = total.toFixed(2).replace('.', ',')

  init()
]
