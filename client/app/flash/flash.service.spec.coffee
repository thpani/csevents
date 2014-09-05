'use strict'

describe 'Service: Flash', ->

  # load the service's module
  beforeEach module 'cseventsApp'
  scope = undefined

  # instantiate service
  Flash = undefined
  beforeEach inject (_Flash_, $rootScope) ->
    Flash = _Flash_
    scope = $rootScope

  it 'initializes queue to empty', ->
    expect(Flash.getMessages()).toEqual []

  it 'accepts various message types', ->
    Flash.info 'i'
    Flash.success 's'
    Flash.warn 'w'
    Flash.error 'e'
    expect(Flash.getMessages().length).toEqual 4
    expect(_.map(Flash.getMessages(), (msg) -> msg.type)).toEqual [ 'info', 'success', 'warning', 'danger' ]

  it 'delegates message types to log', ->
    spyOn Flash, 'log'

    Flash.info 'i'
    Flash.success 's'
    Flash.warn 'w'
    Flash.error 'e'

    expect(Flash.log).toHaveBeenCalled()

  it 'dismisses messages', ->
    Flash.info 'i'
    Flash.success 's'
    Flash.warn 'w'
    Flash.error 'e'

    expect(Flash.getMessages().length).toEqual 4

    Flash.dismiss 0

    expect(Flash.getMessages().length).toEqual 3
    expect(_.map(Flash.getMessages(), (msg) -> msg.msg)).toEqual [ 's', 'w', 'e' ]

    Flash.dismiss 2

    expect(Flash.getMessages().length).toEqual 2
    expect(_.map(Flash.getMessages(), (msg) -> msg.msg)).toEqual [ 's', 'w' ]

  it 'clears queue on state change', ->
    Flash.info 'i'
    Flash.success 's'
    Flash.warn 'w'
    Flash.error 'e'

    expect(Flash.getMessages().length).toEqual 4

    scope.$emit "$stateChangeSuccess"

    expect(Flash.getMessages().length).toEqual 0
