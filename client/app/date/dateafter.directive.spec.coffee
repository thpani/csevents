'use strict'

describe 'Directive: dateafter', ->

  # load the directive's module and view
  beforeEach module 'cseventsApp'
  element = undefined
  scope = undefined
  ngModelController = undefined

  beforeEach inject ($rootScope, $compile, ngModelDirective) ->
    scope = $rootScope.$new()
    scope.event = {}

    ngModel = ngModelDirective[0]
    ngModel.link = ->
    ngModel.controller = ->
      this.$setValidity = jasmine.createSpy()
      ngModelController = this

    element = angular.element '<datepicker dateafter ng-model="event.date_to"></datepicker>'
    element = $compile(element) scope

  it 'should validate if both undefined', ->

    scope.$apply()

    expect(scope.event.date_from).toBeUndefined()
    expect(scope.event.date_to).toBeUndefined()

    expect(ngModelController.$setValidity).toHaveBeenCalledWith 'dateafter', true
    expect(ngModelController.$setValidity).not.toHaveBeenCalledWith 'dateafter', false

  it 'should validate if from is defined and to is undefined', ->
    scope.event.date_from = moment("1995-12-25")

    scope.$apply()

    expect(scope.event.date_from).toBeDefined()
    expect(scope.event.date_to).toBeUndefined()

    expect(ngModelController.$setValidity).toHaveBeenCalledWith 'dateafter', true
    expect(ngModelController.$setValidity).not.toHaveBeenCalledWith 'dateafter', false

  it 'should validate if from is undefined and to is defined', ->
    scope.event.date_to = moment("1995-12-25")

    scope.$apply()

    expect(scope.event.date_from).toBeUndefined()
    expect(scope.event.date_to).toBeDefined()

    expect(ngModelController.$setValidity).toHaveBeenCalledWith 'dateafter', true
    expect(ngModelController.$setValidity).not.toHaveBeenCalledWith 'dateafter', false

  it 'should validate if order is correct', ->
    scope.event.date_from = moment("1995-12-24")
    scope.event.date_to = moment("1995-12-25")

    scope.$apply()

    expect(scope.event.date_from).toBeDefined()
    expect(scope.event.date_to).toBeDefined()
    expect(scope.event.date_from).toBeLessThan scope.event.date_to

    expect(ngModelController.$setValidity).toHaveBeenCalledWith 'dateafter', true
    expect(ngModelController.$setValidity).not.toHaveBeenCalledWith 'dateafter', false

  it 'should NOT validate if dates are same', ->
    scope.event.date_from = moment("1995-12-25")
    scope.event.date_to = moment("1995-12-25")

    scope.$apply()

    expect(scope.event.date_from).toBeDefined()
    expect(scope.event.date_to).toBeDefined()
    expect(scope.event.date_from).toEqual scope.event.date_to

    expect(ngModelController.$setValidity).not.toHaveBeenCalledWith 'dateafter', true
    expect(ngModelController.$setValidity).toHaveBeenCalledWith 'dateafter', false

  it 'should NOT validate if from is after to', ->
    scope.event.date_from = moment("1995-12-26")
    scope.event.date_to = moment("1995-12-25")

    scope.$apply()

    expect(scope.event.date_from).toBeDefined()
    expect(scope.event.date_to).toBeDefined()
    expect(scope.event.date_from).toBeGreaterThan scope.event.date_to

    expect(ngModelController.$setValidity).not.toHaveBeenCalledWith 'dateafter', true
    expect(ngModelController.$setValidity).toHaveBeenCalledWith 'dateafter', false
