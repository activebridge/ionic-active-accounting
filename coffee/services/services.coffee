angular.module('active-accounting').factory 'Counterparty', [
  '$resource', ($resource) ->
    $resource '/api/counterparties/:id', { id: '@id' }, update: method: 'PUT'
]

angular.module('active-accounting').factory 'Register', [
  '$resource', ($resource) ->
    $resource '/api/registers/:id', { id: '@id' }, update: method: 'PUT'
]

angular.module('active-accounting').factory 'Article', [
  '$resource', ($resource) ->
    $resource '/api/articles/:id', { id: '@id' }, update: method: 'PUT'
]
