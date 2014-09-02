'use strict'

describe 'Service: Event', ->

  # load the service's module
  beforeEach module 'cseventsApp'

  # instantiate service
  Event = undefined
  beforeEach inject (_Event_) ->
    Event = _Event_

  it 'should do something', ->
    expect(1).toBe 0
    # expect(!!Event).toBe true