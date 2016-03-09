app.controller 'ArticleCtrl', [
  '$scope'
  'Article'
  ($scope, Article) ->

    $scope.revenues = {}
    $scope.costs = {}
    $scope.translations = {}
    $scope.loans = {}

    $scope.loadArticles = ->
      Article.query (response) ->
        $scope.articles = response

    $scope.toggleGroup = (group) ->
      if $scope.isGroupShown(group)
        $scope.shownGroup = null
      else
        $scope.shownGroup = group

    $scope.isGroupShown = (group) ->
      $scope.shownGroup == group

    init = ->
      $scope.loadArticles()

    init()
]
