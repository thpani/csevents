'use strict'

angular.module 'cseventsApp'
.controller 'EventseriesDetailCtrl', ($scope, $stateParams, EventSeries, Event) ->
  $scope.event = EventSeries.get(id: $stateParams.id)
  $scope.events = Event.query(series: $stateParams.id)
