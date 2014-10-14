'use strict'

angular.module 'cseventsApp'
.service 'EventSeries', (Resource) ->

  Resource '/api/eventseries/:id',
    id: '@_id'

.service 'Invitation', (Resource) ->

  Resource '/api/invitations/:id',
    id: '@_id'
