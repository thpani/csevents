'use strict'

angular.module 'cseventsApp'
.controller 'EventCtrl', ($scope, $state, $stateParams, Event, $upload) ->
  $scope.event = if $stateParams.id? then Event.get(id: $stateParams.id) else new Event

  $scope.submit = () ->
    newEvent = new Event $scope.event
    newEvent.$save(
      -> $state.go('events'),
      (httpResponse) -> console.log(httpResponse) # TODO
    )
