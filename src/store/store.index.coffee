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
  'ee-button-add-to-cart'
  'ee-product'
  'ee-overlay'
  # 'ee-offscreen'
  # 'ee.templates' # commented out during build step for inline templates
]
