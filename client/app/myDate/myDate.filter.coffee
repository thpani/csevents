'use strict'

angular.module 'cseventsApp'
.filter 'myDate', ($filter) ->
  (input) -> $filter('date')(input, 'EEEE, MMM d, y H:mm')
