'use strict'

angular.module('builder.is').controller 'isCtrl', ($state, eeAuth, eeDefiner) ->

  that = this
  this.authExp = eeAuth.exports

  states = [
    'your-own-business'
    'beautiful-and-customizable'
    'easy-to-use'
    'everything-you-need'
  ]
  length = states.length

  increment = (n) ->
    i = states.indexOf $state.current.name
    next = (i + n) % length
    if next < 0 then next = length - 1
    $state.go states[next]
    return

  this.next = () -> increment 1
  this.previous = () -> increment -1

  this.signup = () ->
    eeAuth.fns.createUserFromEmail that.email, eeDefiner.exports.proposition
    .then (user) -> $state.go 'go', token: user.go_token
    .catch (err) ->
      if err.message is 'Email format is invalid' then return that.error = 'That doesn\'t look like a valid email address. Please try again.'
      if err.message is 'Account exists' then return $state.transitionTo 'login', { exists: true }
      that.error = 'Problem signing up'

  return
