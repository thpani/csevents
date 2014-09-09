'use strict'

angular.module 'cseventsApp'
.config ($stateProvider) ->
  $stateProvider.state 'eventseries',
    url: '/eventseries'
    templateUrl: 'app/eventseries/eventseries.html'
    controller: 'EventseriesCtrl'
    authenticate: true

  .state 'eventseries.new',
    url: '/new'
    templateUrl: 'app/eventseries/edit.html'
    controller: 'EventseriesEditCtrl'
    authenticate: true

  .state 'eventseries.edit',
    url: '/:id/edit'
    templateUrl: 'app/eventseries/edit.html'
    controller: 'EventseriesEditCtrl'
    authenticate: true
