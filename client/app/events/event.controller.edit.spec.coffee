'use strict'

describe 'Controller: EventCtrl in edit mode', ->

  # load the controller's module
  beforeEach module 'cseventsApp'

  EventCtrl = undefined
  scope = undefined
  stateServiceMock = undefined
  stateParamsMock = undefined
  eventServiceMock = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    scope.form = {}

    stateServiceMock =
      go: jasmine.createSpy()
    stateParamsMock =
      id: 'abc'
    eventServiceMock = ->
    eventServiceMock.get = (evt) ->
      _id: evt.id
      $save: -> _id: evt.id
    eventServiceMock.prototype.$save = -> _id: this.id

    EventCtrl = $controller 'EventCtrl',
      $scope: scope
      $state: stateServiceMock
      $stateParams: stateParamsMock
      Event: eventServiceMock

  it 'queries Event', ->
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
    expect(stateServiceMock.go).toHaveBeenCalledWith('events')

  it 'does not change state on save fail', ->
    expect(stateServiceMock.go).not.toHaveBeenCalled()
    spyOn(scope.event, '$save').andCallFake((success, fail) -> fail(data: {}))
    scope.submit()
    expect(stateServiceMock.go).not.toHaveBeenCalled()

  it 'prepends protocol to non-URLs', ->
    expect(scope.event.speaker_url).toBeUndefined()
    scope.submit()
    expect(scope.event.speaker_url).toBeUndefined()

    scope.event.speaker_url = 'forsyte.at'
    scope.submit()
    expect(scope.event.speaker_url).toEqual 'http://forsyte.at'

    scope.event.speaker_url = 'https://thpani.net'
    scope.submit()
    expect(scope.event.speaker_url).toEqual 'https://thpani.net'
