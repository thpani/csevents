'use strict'

angular.module 'cseventsApp'
.controller 'EventsCtrl', ($scope, $state, Event, socket) ->
  $scope.events = Event.query()

  # sync updates
  socket.syncUpdates 'event', $scope.events
  $scope.$on '$destroy', -> socket.unsyncUpdates 'event'

  $scope.delete = (event) ->
    Event.delete(id: event._id)

  $scope.edit = (event) -> $state.go('events.edit', id: event._id)
