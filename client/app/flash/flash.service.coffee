'use strict'

angular.module 'cseventsApp'
.factory 'Flash', ($rootScope) ->

  queue = []

  $rootScope.$on "$stateChangeSuccess", ->
    while queue.length
      queue.pop()

  log: (type, msg, h) -> queue.push(type: type, msg: msg, h: h)
  success: (msg) -> this.log('success', msg, 'Success')
  info: (msg) -> this.log('info', msg, 'Info')
  warn: (msg) -> this.log('warning', msg, 'Warning')
  error: (msg) -> this.log('danger', msg, 'Error')

  getMessages: -> queue
  dismiss: (idx) -> queue.splice(idx, 1)
