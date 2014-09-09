'use strict'

angular.module 'cseventsApp'
.controller 'EventseriesCtrl', ($scope, $state, socket, EventSeries) ->
  $scope.eventseries = EventSeries.query()

  # sync updates
  socket.syncUpdates 'eventseries', $scope.eventseries
  $scope.$on '$destroy', -> socket.unsyncUpdates 'eventseries'

  $scope.delete = (event) ->
    EventSeries.delete(id: event._id)

  $scope.edit = (event) -> $state.go('eventseries.edit', id: event._id)
