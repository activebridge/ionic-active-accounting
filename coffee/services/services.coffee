app.factory 'Register', [
  '$resource', ($resource) ->
    $resource apiEndpoint + '/registers/:id', { id: '@id' }, update: method: 'PUT'
]

app.factory 'Article', [
  '$resource', ($resource) ->
    $resource apiEndpoint + '/articles/:id', { id: '@id' }, update: method: 'PUT'
]

app.factory 'Vendor', [
  '$resource', ($resource) ->
    $resource apiEndpoint + '/vendor_login/:id.json', { id: '@id' }, update: method: 'PUT'
  ]

app.factory 'Tax', [
  '$resource', ($resource) ->
    $resource apiEndpoint + '/tax/', {id: '@id'}, edit: url: apiEndpoint + '/tax/edit', method: 'GET', isArray: false
]

app.factory 'Hours', [
  '$resource', ($resource) ->
    $resource apiEndpoint + '/hours/:id/:action', {id: '@id'}, update: method: 'PUT'
]

app.factory 'Counterparty', ['$resource', ($resource) ->
  $resource apiEndpoint + '/counterparties/:id/:action',
    id: '@id'
  , customers:
    method: 'GET',
    params:
      action: 'customers'
    isArray: true
  , update:
    method: 'PUT'
]

app.factory 'WorkDay', ['$resource', ($resource) ->
  $resource apiEndpoint + '/work_days/'
]

app.factory 'Holiday', ['$resource', ($resource) ->
  $resource apiEndpoint + '/holidays/:id/:action',
    id: '@id'
  , update:
    method: 'PUT'
]

app.factory 'Holiday', ['$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
  $resource apiEndpoint + '/holidays/:id/:action',
    id: '@id'
  , update:
    method: 'PUT'
]
