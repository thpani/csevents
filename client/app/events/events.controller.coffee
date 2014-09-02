'use strict'

angular.module 'cseventsApp'
.controller 'EventsCtrl', ($scope, Event, socket) ->
  $scope.events = Event.query()

  # sync updates
  socket.syncUpdates 'event', $scope.events
  $scope.$on '$destroy', -> socket.unsyncUpdates 'event'

  $scope.delete = (event) ->
    Event.delete(id: event._id)
