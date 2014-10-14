'use strict'

angular.module 'cseventsApp'
.controller 'InvitationCtrl', ($scope, $state, $stateParams, $http, Flash) ->
  $http.get('/api/invitations/' + $stateParams.id)
    .success (data, status, headers, config) ->
      $scope.eventseries = data.eventseries
    .error (data, status, headers, config) ->
      $scope.fail = true
