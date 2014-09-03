'use strict'

angular.module 'cseventsApp'
.config ($stateProvider) ->
  $stateProvider

  .state 'events',
    url: '/events'
    templateUrl: 'app/events/events.html'
    controller: 'EventsCtrl'
    authenticate: true

  .state 'events.new',
    url: '/new'
    templateUrl: 'app/events/events.edit.html'
    controller: 'EventCtrl'
    authenticate: true

  .state 'events.edit',
    url: '/edit/:id'
    templateUrl: 'app/events/events.edit.html'
    controller: 'EventCtrl'
    authenticate: true
