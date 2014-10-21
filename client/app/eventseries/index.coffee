'use strict'

angular.module 'cseventsApp'
.controller 'EventseriesCtrl', ($scope, socket, EventSeries) ->
  $scope.eventseries = EventSeries.query()

  # sync updates
  socket.syncUpdates 'eventseries', $scope.eventseries
  $scope.$on '$destroy', -> socket.unsyncUpdates 'eventseries'

  $scope.delete = (event) ->
    EventSeries.delete(id: event._id)
