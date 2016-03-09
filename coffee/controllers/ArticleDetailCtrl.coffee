app.controller 'ArticleDetailCtrl', [
  '$scope'
  '$state'
  '$ionicPopup'
  '$stateParams'
  'Article'
  'articleTypes'
  ($scope, $state, $ionicPopup, $stateParams, Article, articleTypes) ->

    $scope.getArticle = ->
      Article.get
        id: $stateParams.articleId
      , (response) ->
        $scope.article = response

    $scope.deleteArticle = (id) ->
      confirmPopup = $ionicPopup.confirm
        title: 'Видалення'
        template: 'Ви впевнені в своєму рішенні?'
      confirmPopup.then (response) ->
        if response
          Article.delete
            id: id
          , ->
            $state.go 'admin.article'

    $scope.updateArticle = ->
      Article.update $scope.article
      , ->
        $state.go 'admin.article'

    init = ->
      $scope.types = articleTypes
      $scope.getArticle()

    init()
]
