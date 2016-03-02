app.controller 'ArticleCtrl', [
  '$scope'
  'Article'
  ($scope, Article) ->

    $scope.loadArticles = ->
      Article.query (response) ->
        $scope.articles = response

    init = ->
      $scope.loadArticles()

    init()
]
