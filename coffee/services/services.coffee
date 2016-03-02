app.factory 'Register', [
  '$resource', ($resource) ->
    $resource '/api/registers/:id', { id: '@id' }, update: method: 'PUT'
]

app.factory 'Article', [
  '$resource', ($resource) ->
    $resource '/api/articles/:id', { id: '@id' }, update: method: 'PUT'
]

app.factory 'Vendor', [
  '$resource', ($resource) ->
    $resource '/api/vendor_login/:id.json', { id: '@id' }, update: method: 'PUT'
  ]

app.factory 'Tax', [
  '$resource', ($resource) ->
    $resource '/api/tax/', {id: '@id'}, edit: url: '/api/tax/edit', method: 'GET', isArray: false
]

app.factory 'Hours', [
  '$resource', ($resource) ->
    $resource '/api/hours/:id/:action', {id: '@id'}, update: method: 'PUT'
]

app.factory 'Counterparty', ['$resource', ($resource) ->
  $resource '/api/counterparties/:id/:action',
    id: '@id'
  , customers:
    method: 'GET',
    params:
      action: 'customers'
    isArray: true
  , update:
    method: 'PUT'
]
