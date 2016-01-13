'use strict'

angular.module 'eeBuilder', [
  # vendor
  'ngCookies'
  'ngAnimate'
  'ui.router'
  'ui.bootstrap'
  # 'ngSanitize'
  # 'angulartics'
  # 'angulartics.google.analytics'
  # 'colorpicker.module'
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
  'builder.dashboard'
  'builder.date'
  'builder.storefront'
  'builder.products'
  # 'builder.templates'
  'builder.collections'
  'builder.categorizations'
  'builder.orders'
  'builder.account'
  'builder.example'
  'builder.edit'
  'builder.promotions'

  # custom
  'ee-terms-seller'
  'ee-terms-privacy'
  'ee-builder-navbar'
  'ee-builder-live-button'
  'ee-builder-section-heading'
  'ee-save'
  'ee-loading'
  'ee-product-builder-buttons'
  'ee-product-card'
  'ee-product-for-builder'
  'ee-product-for-store'
  'ee-products-in-collection'
  'ee-product-images'
  'ee-price-editor'
  'ee-collection-nav'
  'ee-collection-edit-card'
  'ee-collection-add-card'
  'ee-collection-for-builder'
  'ee-order'
  'ee-cloudinaryUpload'
  'ee-image-preload'
  'ee-storefront-header'
  'ee-storefront-logo'
  'ee-storefront-brand'
  'ee-scroll-to-top'
  'ee-empty-message'
  'ee-zendesk'
  'ee-web-colorpicker'
  'ee-datepicker'
  # 'ee.templates' # commented out during build step for inline templates
]
