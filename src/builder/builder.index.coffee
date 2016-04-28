'use strict'

angular.module 'eeBuilder', [
  # vendor
  'ngCookies'
  'ngAnimate'
  'ui.router'
  'ui.bootstrap'
  'rzModule'
  'ngSanitize'
  'angulartics'
  'angulartics.google.analytics'
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
  'builder.homepage'
  'builder.settings'
  'builder.terms'
  'builder.daily'
  'builder.tracks'
  'builder.brand'
  'builder.start'
  'builder.date'
  'builder.storefront'
  # 'builder.products'
  'builder.collections'
  # 'builder.categorizations'
  'builder.orders'
  'builder.account'
  'builder.example'
  'builder.edit' # Remove once about page is transitioned
  'builder.promotions'
  'builder.live'

  # builder components
  'ee-terms-seller'
  'ee-terms-privacy'
  'ee-builder-navbar'
  'ee-builder-live-button'
  'ee-builder-section-heading'
  'ee-builder-activity'
  'ee-save'
  'ee-product-builder-buttons'
  'ee-product-for-builder'
  'ee-price-editor'
  'ee-collection-for-builder'
  'ee-cloudinaryUpload'
  'ee-zendesk'
  'ee-web-colorpicker'
  'ee-font-selector'
  'ee-builder-track-nav'
  # 'ee-image-layer-editor' # TODO remove once ee-layers is finished
  # 'ee-layers'
  'ee-canvas'
  'ee-unsplash-search'
  'ee-guide-button'
  'ee-collection-carousel'

  # shared components
  'ee-loading'
  'ee-product-card'
  'ee-product-for-store'
  'ee-products-in-collection'
  'ee-product-images'
  'ee-collection-for-store'
  'ee-collection-nav'
  'ee-collection-image-preview'
  'ee-order'
  'ee-image-preload'
  'ee-storefront-header'
  'ee-storefront-scroller'
  'ee-storefront-brand'
  'ee-scroll-to-top'
  'ee-empty-message'
  'ee-datepicker'
  # 'ee.templates' # commented out during build step for inline templates
]
