app.config [
  '$authProvider'
  '$httpProvider'
  'apiEndpoint'
  ($authProvider, $httpProvider, apiEndpoint) ->
    $authProvider.withCredentials = true
    $authProvider.httpInterceptor = true
    $authProvider.baseUrl = apiEndpoint
    $authProvider.loginUrl = '/vendor_login.json'
    $authProvider.tokenName = 'auth_token'
    $authProvider.tokenPrefix = 'satellizer'
    $authProvider.authHeader = 'Authorization'
    $authProvider.authToken = 'Bearer'
    $authProvider.cordova = true
  ]
