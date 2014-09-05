'use strict'

describe 'Controller: FlashCtrl', ->

  # load the controller's module
  beforeEach module 'cseventsApp'
  FlashCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FlashCtrl = $controller 'FlashCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
