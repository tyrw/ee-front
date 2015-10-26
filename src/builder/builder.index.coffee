'use strict'

angular.module 'eeBuilder', [
  # vendor
  'ui.router'
  'ui.bootstrap'
  'ngCookies'
  'ngSanitize'
  'angulartics'
  'angulartics.google.analytics'
  'colorpicker.module'
  # 'angularFileUpload'

  # core
  'app.core'

  # builder
  'builder.core'
  'builder.auth'
  'builder.contact'
  'builder.landing'
  'builder.go'
  'builder.is'
  'builder.create'
  'builder.terms'
  'builder.storefront'
  'builder.products'
  'builder.templates'
  'builder.collections'
  'builder.orders'
  'builder.account'
  'builder.example'
  'builder.edit'
  'builder.promotions'

  # custom
  'ee-terms-seller'
  'ee-terms-privacy'
  'ee-builder-navbar'
  'ee-builder-section-heading'
  'ee-save'
  'ee-loading'
  'ee-product-card'
  'ee-product-editor-card'
  'ee-product-for-store'
  'ee-products-in-collection'
  'ee-product-images'
  'ee-collection-nav'
  'ee-collection-card'
  'ee-collection-add-card'
  'ee-collection-editor-card'
  'ee-order'
  'ee-cloudinaryUpload'
  'ee-image-preload'
  'ee-storefront-header'
  'ee-scroll-to-top'
  'ee-empty-message'
  'ee-zendesk'
  # 'ee.templates' # commented out during build step for inline templates
]
