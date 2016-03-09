app.controller 'ArticleNewCtrl', [
  '$scope'
  '$state'
  'Article'
  ($scope, $state, Article) ->

    $scope.types = [
      'Revenue',
      'Cost',
      'Translation',
      'Loan'
    ]

    $scope.article = {}

    $scope.saveArticle = ->
      Article.save($scope.article
      , ->
        $scope.article.errors = {}
        $state.go 'admin.article'
      )
]
