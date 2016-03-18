app.controller 'ArticleCtrl', [
  '$scope'
  'Article'
  'toggleDecorator'
  ($scope, Article, toggleDecorator) ->
    toggleDecorator($scope)
    
    $scope.loadArticles = ->
      Article.query (response) ->
        $scope.articles = response

    init = ->
      $scope.revenues = {}
      $scope.costs = {}
      $scope.translations = {}
      $scope.loans = {}
      $scope.loadArticles()

    init()
]
