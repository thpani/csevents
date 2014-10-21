'use strict'

describe 'Controller: EventseriesCtrl', ->

  # load the controller's module
  beforeEach module 'cseventsApp'
  EventseriesCtrl = undefined
  scope = undefined
  eventSeriesServiceMock = undefined
  sockMock = undefined
  stateMock = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    eventSeriesServiceMock =
      query: -> []
      delete: jasmine.createSpy()
    sockMock =
      syncUpdates: jasmine.createSpy()
      unsyncUpdates: jasmine.createSpy()
    stateMock =
        go: jasmine.createSpy()
    EventseriesCtrl = $controller 'EventseriesCtrl',
      $scope: scope
      $state: stateMock
      EventSeries: eventSeriesServiceMock
      socket: sockMock

  it 'queries EventSeries', ->
    expect(scope.eventseries).toEqual []

  it 'syncs updates', ->
    expect(sockMock.syncUpdates).toHaveBeenCalledWith('eventseries', [])

  it 'unsyncs updates on destroy', ->
    scope.$emit '$destroy'
    expect(sockMock.unsyncUpdates).toHaveBeenCalledWith('eventseries')

  it 'calls EventSeries on delete', ->
    scope.delete(_id: 'abc')
    expect(eventSeriesServiceMock.delete).toHaveBeenCalledWith(id: 'abc')
