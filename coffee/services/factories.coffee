angular.module('active-accounting').factory 'Vendor', [
  '$resource', ($resource) ->
    $resource '/api/vendor_login/:id.json', { id: '@id' }, update: method: 'PUT'
]
