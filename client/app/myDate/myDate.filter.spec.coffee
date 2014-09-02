'use strict'

describe 'Filter: myDate', ->

  # load the filter's module
  beforeEach module 'cseventsApp'

  # initialize a new instance of the filter before each test
  myDate = undefined
  beforeEach inject ($filter) ->
    myDate = $filter 'myDate'

  it 'should return the input prefixed with \'myDate filter:\'', ->
    text = 'angularjs'
    expect(myDate text).toBe 'myDate filter: ' + text
