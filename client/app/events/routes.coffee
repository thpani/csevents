'use strict'

angular.module 'cseventsApp'
.config ($stateProvider) ->
  $stateProvider

  .state 'events',
    url: '/events'
    templateUrl: 'app/events/index.html'
    controller: 'EventsCtrl'
    authenticate: true

  .state 'events.new',
    url: '/new'
    templateUrl: 'app/events/edit.html'
    controller: 'EventCtrl'
    authenticate: true

  .state 'events.edit',
    url: '/:id/edit'
    templateUrl: 'app/events/edit.html'
    controller: 'EventCtrl'
    authenticate: true
