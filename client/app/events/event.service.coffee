'use strict'

angular.module 'cseventsApp'
.factory 'Event', (Resource) ->

  Resource '/api/events/:id',
    id: '@_id'
