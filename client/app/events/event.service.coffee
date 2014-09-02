'use strict'

angular.module 'cseventsApp'
.factory 'Event', ($resource) ->

  $resource '/api/events/:id/:controller',
    id: '@_id'
