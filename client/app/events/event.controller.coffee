'use strict'

angular.module 'cseventsApp'
.controller 'EventCtrl', ($scope, $state, $stateParams, Event, $upload) ->
  $scope.event = if $stateParams.id? then Event.get(id: $stateParams.id) else new Event

  $scope.submit = () ->
    su = $scope.event.speaker_url
    if su? and not _.contains(su, '//')
      $scope.event.speaker_url = 'http://'+su

    $scope.event.$save(
      -> $state.go('events'),
      (httpResponse) -> console.log(httpResponse) # TODO
    )
