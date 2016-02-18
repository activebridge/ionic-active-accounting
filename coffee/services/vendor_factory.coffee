angular.module('active-accounting').factory 'Vendor', [
  '$resource', ($resource) ->
    $resource '/api/vendor_login/:id', { id: '@id' }, update: method: 'PUT'
]
