'use strict'

angular.module 'eeStore', [
  # vendor
  'ui.router'
  'ui.bootstrap'
  'ngCookies'
  'ngSanitize'
  'angulartics'
  'angulartics.google.analytics'

  # core
  'app.core'

  # store
  'store.core'

  # custom
  'ee-product'
  # 'ee-offscreen'
  # 'EE.Templates' # commented out during build step for inline templates
]
