app.controller 'ChartsCtrl', [
  '$scope'
  'Chart'
  'Register'
  ($scope, Chart, Register) ->
    init = ->
      $scope.current = {}
      $scope.current.year = new Date().getFullYear()
      $scope.barChartData = []
      $scope.lineChartData = []
      $scope.months = moment.months()
      $scope.series = ['Revenue', 'Cost', 'Profit']
      loadYears()

    loadYears = ->
      Chart.years (response) ->
        $scope.years = response['charts']
        $scope.load($scope.current.year)

    $scope.load = (year) ->
      $scope.data = Chart.query
        year: year,
        (response) ->
          revenueData     = [0,0,0,0,0,0,0,0,0,0,0,0]
          costData        = [0,0,0,0,0,0,0,0,0,0,0,0]
          profitData      = [0,0,0,0,0,0,0,0,0,0,0,0]
          lineData        = [0,0,0,0,0,0,0,0,0,0,0,0]

          for key in response
            $scope.average = 0
            index = key.month - 1
            count = 0
            revenueData[index] = key.revenue
            profitData[index] = key.profit
            costData[index] = key.cost
            
            unless key.revenue == 0 && key.cost == 0
              lineData[index] = parseFloat(Math.round(((key.revenue - key.cost) * 100) / key.revenue).toFixed(2))
              $scope.average += lineData[index]
              count += 1

          $scope.average /= count
          $scope.lineChartData = [lineData]
          $scope.barChartData = [revenueData, costData, profitData]

    init()
]
