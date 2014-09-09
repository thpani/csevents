'use strict'

describe 'Controller: EventseriesEditCtrl in edit mode', ->

  # load the controller's module
  beforeEach module 'cseventsApp'

  EventseriesEditCtrl = undefined
  scope = undefined
  stateServiceMock = undefined
  stateParamsMock = undefined
  eventSeriesServiceMock = undefined
  flashServiceMock = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, Flash) ->
    scope = $rootScope.$new()
    scope.form = {}

    stateServiceMock =
      go: jasmine.createSpy()
    stateParamsMock =
      id: 'abc'
    eventSeriesServiceMock = ->
    eventSeriesServiceMock.get = (evt) ->
      _id: evt.id
      $save: -> _id: evt.id
    eventSeriesServiceMock.prototype.$save = -> _id: this.id

    EventseriesEditCtrl = $controller 'EventseriesEditCtrl',
      $scope: scope
      $state: stateServiceMock
      $stateParams: stateParamsMock
      EventSeries: eventSeriesServiceMock
      Flash: Flash

  it 'queries EventSeries', ->
    expect(scope.event).toBeDefined()
    expect(scope.event._id).toEqual 'abc'

  it 'sets action string', ->
    expect(scope.action).toEqual 'Edit'

  it 'sets form.$submitted on submit', ->
    expect(scope.form.$submitted).toBeUndefined()
    scope.submit()
    expect(scope.form.$submitted).toEqual 'submitted'

  it 'calls event.$save on submit', ->
    spyOn(scope.event, '$save')
    expect(scope.event.$save).not.toHaveBeenCalled()
    scope.submit()
    expect(scope.event.$save).toHaveBeenCalled()

  it 'changes state on save success', ->
    expect(stateServiceMock.go).not.toHaveBeenCalled()
    spyOn(scope.event, '$save').andCallFake((success, fail) -> success())
    scope.submit()
    expect(stateServiceMock.go).toHaveBeenCalledWith('eventseries')

  it 'does not change state on save fail', ->
    expect(stateServiceMock.go).not.toHaveBeenCalled()
    spyOn(scope.event, '$save').andCallFake((success, fail) -> fail(data: {}))
    scope.submit()
    expect(stateServiceMock.go).not.toHaveBeenCalled()

  it 'flashes message on save fail', inject (Flash) ->
    expect(Flash.getMessages().length).toEqual 0
    spyOn(scope.event, '$save').andCallFake((success, fail) -> fail(data: {}))
    scope.submit()
    expect(Flash.getMessages().length).toEqual 1
