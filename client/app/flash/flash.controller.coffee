'use strict'

angular.module 'cseventsApp'
.controller 'FlashCtrl', ($scope, $rootScope, Flash) ->
  $scope.flash = Flash
