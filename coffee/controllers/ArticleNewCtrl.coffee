app.controller 'ArticleNewCtrl', [
  '$scope'
  '$state'
  'Article'
  'articleTypes'
  ($scope, $state, Article, articleTypes) ->

    $scope.saveArticle = ->
      Article.save($scope.article
      , ->
        $scope.article.errors = {}
        $state.go 'admin.article'
      )

    init = ->
      $scope.article = {}
      $scope.types = articleTypes

    init()
]
