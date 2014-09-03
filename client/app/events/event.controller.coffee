'use strict'

angular.module 'cseventsApp'
.controller 'EventCtrl', ($scope, $state, $stateParams, Event, $upload) ->
  $scope.event = if $stateParams.id? then Event.get(id: $stateParams.id) else new Event

  $scope.submit = () ->
    $scope.event.$save(
      -> $state.go('events'),
      (httpResponse) -> console.log(httpResponse) # TODO
    )
