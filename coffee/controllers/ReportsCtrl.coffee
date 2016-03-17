app.controller 'ReportsCtrl', [
  '$scope'
  'Report'
  'Register'
  'Article'
  'Counterparty'
  'toggleDecorator'
  ($scope, Report, Register, Article, Counterparty, toggleDecorator) ->
    toggleDecorator($scope)

    init = ->
      $scope.current = {}
      $scope.current.year = moment().format('YYYY')
      $scope.current.month = moment().format('M/')
      $scope.years = [2015..parseInt($scope.current.year) + 1]
      $scope.months = []
      count = 0
      for key in moment.months()
        count += 1
        $scope.months.push
          value: count + "/"
          text: key
      $scope.loadReports()


    $scope.loadReports = ->
      $scope.index = parseInt($scope.current.month)

      Report.query
        report_type: 'revenues'
        'months[]': [$scope.current.month + $scope.current.year]
        rate_currency: "0"
        , (response) ->
          $scope.revenues = response[0].articles
          $scope.totalRevenue = response[0].total_values

      Report.query
        report_type: 'costs'
        'months[]': [$scope.current.month + $scope.current.year]
        rate_currency: "0"
        , (response) ->
          $scope.costs = response[0].articles
          $scope.totalCost = response[0].total_values

      Report.query
        report_type: 'translations'
        'months[]': [$scope.current.month + $scope.current.year]
        rate_currency: "0"
        , (response) ->
          $scope.translations = response[0].articles
          $scope.totalTranslation = response[0].total_values

      Report.query
        report_type: 'loans'
        'months[]': [$scope.current.month + $scope.current.year]
        rate_currency: "0"
        , (response) ->
          $scope.loans = response[0].articles
          $scope.totalLoan = response[0].total_values

    init()
]
