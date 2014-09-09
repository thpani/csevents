'use strict'

angular.module 'cseventsApp'
.config ($stateProvider) ->
  $stateProvider.state 'eventseries',
    url: '/eventseries'
    templateUrl: 'app/eventseries/eventseries.html'
    controller: 'EventseriesCtrl'
