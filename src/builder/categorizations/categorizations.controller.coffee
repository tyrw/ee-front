'use strict'

angular.module('builder.categorizations').controller 'categorizationsCtrl', (eeDefiner, eeCategorizations) ->

  categorizations = this

  categorizations.ee  = eeDefiner.exports
  categorizations.fns = eeCategorizations.fns

  eeCategorizations.fns.getCategorizations()

  return
