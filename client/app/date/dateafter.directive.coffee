'use strict'

angular.module 'cseventsApp'
.directive 'dateafter', ->
  restrict: 'DATEPICKER'
  require: 'ngModel'
  link: (scope, element, attrs, ctrl) ->

    scope.$watch 'event.date_from', (newValue) ->
      ctrl.$setValidity('dateafter', not scope.event.date_from? or not scope.event.date_to? or scope.event.date_from < scope.event.date_to)

    scope.$watch 'event.date_to', (newValue) ->
      ctrl.$setValidity('dateafter', not scope.event.date_from? or not scope.event.date_to? or scope.event.date_from < scope.event.date_to)
