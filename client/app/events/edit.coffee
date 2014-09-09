'use strict'

angular.module 'cseventsApp'
.controller 'EventCtrl', ($scope, $state, $stateParams, Event, Flash) ->
  $scope.event = if $stateParams.id? then Event.get(id: $stateParams.id) else new Event
  $scope.action = if $stateParams.id? then "Edit" else "Add new"

  $scope.submit = () ->
    $scope.form.$submitted = "submitted"
    return if $scope.form.$invalid

    su = $scope.event.speaker_url
    if su? and not _.contains(su, '//')
      $scope.event.speaker_url = "http://#{su}"

    $scope.event.$save(
      -> $state.go('events'),
      (resp) ->
        if resp.data.errors
          _.each(resp.data.errors, (field) -> Flash.error("#{field.message}."))
        else
          Flash.error "Server returned #{resp.status} #{resp.statusText}. #{resp.data.message}."
    )
