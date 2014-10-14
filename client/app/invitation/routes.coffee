'use strict'

angular.module 'cseventsApp'
.config ($stateProvider) ->
  $stateProvider.state 'invitation',
    url: '/invitation/:id'
    templateUrl: 'app/invitation/index.html'
    controller: 'InvitationCtrl'
    authenticate: true
