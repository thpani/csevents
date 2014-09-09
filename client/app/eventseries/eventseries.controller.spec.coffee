'use strict'

describe 'Controller: EventseriesCtrl', ->

  # load the controller's module
  beforeEach module 'cseventsApp'
  EventseriesCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    EventseriesCtrl = $controller 'EventseriesCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
