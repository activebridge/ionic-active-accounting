app.factory 'Register', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
    $resource apiEndpoint + '/registers/:id', { id: '@id' }, update: method: 'PUT'
]

app.factory 'Article', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
    $resource apiEndpoint + '/articles/:id', { id: '@id' }, update: method: 'PUT'
]

app.factory 'Vendor', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
    $resource apiEndpoint + '/vendor_login/:id.json', { id: '@id' }, update: method: 'PUT'
  ]

app.factory 'Tax', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
    $resource apiEndpoint + '/tax/', {id: '@id'}, edit: url: apiEndpoint + '/tax/edit', method: 'GET', isArray: false
]

app.factory 'Hours', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
    $resource apiEndpoint + '/hours/:id/:action', {id: '@id'}, update: method: 'PUT'
]

app.factory 'Counterparty', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
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

app.factory 'WorkDay', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
    $resource apiEndpoint + '/work_days/'
]

app.factory 'Holiday', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
    $resource apiEndpoint + '/holidays/:id/:action', {id: '@id'}, update: method: 'PUT'
]

app.factory 'ReportHours', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
    $resource apiEndpoint + '/report_hours/:id'
]

app.factory 'Report', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
    $resource apiEndpoint + '/reports/:id/:action',
      id: '@id'
    , years:
      method: 'GET',
      params:
        action: 'years'
      isArray: false
    , update:
      method: 'PUT'
]

app.factory 'Chart', [
  '$resource', 'apiEndpoint', ($resource, apiEndpoint) ->
    $resource apiEndpoint + '/charts/:id/:action',
      id: '@id'
    , years:
      method: 'GET',
      params:
        action: 'years'
      isArray: false
]
