'use strict'

describe 'Service: Flash', ->

  # load the service's module
  beforeEach module 'cseventsApp'

  # instantiate service
  Flash = undefined
  beforeEach inject (_Flash_) ->
    Flash = _Flash_

  it 'should do something', ->
    expect(!!Flash).toBe true