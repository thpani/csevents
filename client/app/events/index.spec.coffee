'use strict'

describe 'Controller: EventsCtrl', ->

  # load the controller's module
  beforeEach module 'cseventsApp'

  EventsCtrl = undefined
  scope = undefined
  eventServiceMock = undefined
  sockMock = undefined
  stateMock = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    eventServiceMock =
      query: -> []
      delete: jasmine.createSpy()
    sockMock =
      syncUpdates: jasmine.createSpy()
      unsyncUpdates: jasmine.createSpy()
    stateMock =
        go: jasmine.createSpy()
    EventsCtrl = $controller 'EventsCtrl',
      $scope: scope
      $state: stateMock
      Event: eventServiceMock
      socket: sockMock

  it 'queries Event', ->
    expect(scope.events).toEqual []

  it 'syncs updates', ->
    expect(sockMock.syncUpdates).toHaveBeenCalledWith('event', [])

  it 'unsyncs updates on destroy', ->
    scope.$emit '$destroy'
    expect(sockMock.unsyncUpdates).toHaveBeenCalledWith('event')

  it 'calls Event on delete', ->
    scope.delete(_id: 'abc')
    expect(eventServiceMock.delete).toHaveBeenCalledWith(id: 'abc')
