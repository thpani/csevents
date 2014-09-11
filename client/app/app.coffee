'use strict'

angular.module 'cseventsApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'btford.socket-io',
  'ui.router',
  'ui.bootstrap',
  'ui.bootstrap.datetimepicker'
]
.config ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->
  $urlRouterProvider
  .otherwise '/'

  $locationProvider.html5Mode true
  $httpProvider.interceptors.push 'authInterceptor'

.factory 'authInterceptor', ($rootScope, $q, $cookieStore, $location) ->
  # Add authorization token to headers
  request: (config) ->
    config.headers = config.headers or {}
    config.headers.Authorization = 'Bearer ' + $cookieStore.get 'token' if $cookieStore.get 'token'
    config

  # Intercept 401s and redirect you to login
  responseError: (response) ->
    if response.status is 401
      $location.path '/login'
      # remove any stale tokens
      $cookieStore.remove 'token'

    $q.reject response

# Let $save() track if the object is new (POST) or updated (PUT).
# We do this by looking at the `_id' field from mongodb.
#
# Source:
# http://kirkbushell.me/angular-js-using-ng-resource-in-a-more-restful-manner/
# Also see the comments on `apply'!
.factory 'Resource', ($resource) ->
  (url, params, methods) ->

    # http://coffeescriptcookbook.com/chapters/arrays/check-type-is-array
    typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'

    saveTransform = (data, headersGetter) ->
      _.forOwn data, (propVal, propName, object) ->
        if typeIsArray(propVal) and _.all(propVal, (item) -> item._id?)
          object[propName] = _.pluck propVal, '_id'
      angular.toJson data

    defaults =
      update: { method: 'PUT', isArray: false, transformRequest: saveTransform }
      create: { method: 'POST', transformRequest: saveTransform }

    methods = angular.extend defaults, methods

    resource = $resource url, params, methods

    resource.prototype.$save = ->
      if not this._id?
        return this.$create.apply(this, arguments)
      else
        return this.$update.apply(this, arguments)

    return resource

.run ($rootScope, $location, Auth) ->
  # Redirect to login if route requires auth and you're not logged in
  $rootScope.$on '$stateChangeStart', (event, next) ->
    Auth.isLoggedInAsync (loggedIn) ->
      $location.path "/login" if next.authenticate and not loggedIn
