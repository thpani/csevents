'use strict'

angular.module 'cseventsApp'
.controller 'EventCtrl', ($scope, $state, Event) ->
  $scope.event = {}

  $scope.submit = () ->
    newEvent = new Event $scope.event
    newEvent.$save(
      -> $state.go('events'),
      (httpResponse) -> console.log(httpResponse) # TODO
    )
