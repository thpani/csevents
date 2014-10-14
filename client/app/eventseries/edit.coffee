'use strict'

angular.module 'cseventsApp'
.controller 'EventseriesEditCtrl', ($scope, $state, $stateParams, $modal, EventSeries, Flash) ->
  $scope.event = if $stateParams.id? then EventSeries.get(id: $stateParams.id) else new EventSeries
  $scope.action = if $stateParams.id? then "Edit" else "Add new"

  $scope.submit = () ->
    $scope.form.$submitted = "submitted"
    return if $scope.form.$invalid

    $scope.event.$save(
      -> $state.go('eventseries'),
      (resp) ->
        if resp.data.errors
          _.each(resp.data.errors, (field) -> Flash.error("#{field.message}."))
        else
          Flash.error "Server returned #{resp.status} #{resp.statusText}. #{resp.data.message}."
    )

  $scope.addUser = () ->
    modalInstance = $modal.open
      templateUrl: 'EventSeriesUserModal.html'
      controller: 'EventSeriesUserModalCtrl'
      resolve:
        eventseries: () -> $scope.event._id

.controller 'EventSeriesUserModalCtrl', ($scope, $modalInstance, Invitation, Flash, eventseries) ->
  $scope.invitation = new Invitation
  $scope.invitation.eventseries = eventseries
  $scope.ok = ->
    $scope.invitation.$save(
      -> Flash.success "#{$scope.invitation.email} has been invited as admin.",
      (resp) -> Flash.error "Server returned #{resp.status} #{resp.statusText}. #{resp.data.message}."
    )
    $modalInstance.close()
  $scope.cancel = -> $modalInstance.dismiss()
