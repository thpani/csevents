'use strict'

angular.module 'cseventsApp'
.service 'EventSeries', (Resource) ->

  Resource '/api/eventseries/:id',
    id: '@_id'
