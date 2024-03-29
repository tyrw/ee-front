_       = require 'lodash'
sources = {}

stripSrc  = (arr) -> _.map arr, (str) -> str.replace('./src/', '')
toJs      = (arr) -> _.map arr, (str) -> str.replace('.coffee', '.js').replace('./src/', 'js/')
unmin     = (arr) ->
  _.map arr, (str) ->
    str.replace('angulartics/dist/', 'angulartics/src/')
      .replace('angulartics-google-analytics/dist/', 'angulartics-google-analytics/lib/')
      .replace('.min.js', '.js')

sources.builderJs = () ->
  [].concat stripSrc(unmin(sources.builderVendorMin))
    .concat stripSrc(sources.builderVendorUnmin)
    .concat toJs(sources.appModule)
    .concat toJs(sources.builderModule)
    .concat toJs(sources.builderDirective)
    .concat toJs(sources.sharedDirective)

sources.builderModules = () ->
  [].concat sources.appModule
    .concat sources.builderModule
    .concat sources.builderDirective
    .concat sources.sharedDirective

### VENDOR ###
sources.builderVendorMin = [
  # TODO remove once cloudinary jQuery upload & zoom.js are gone
  './src/bower_components/jquery/dist/jquery.min.js'
  './src/bower_components/angular/angular.min.js'
  './src/bower_components/angular-sanitize/angular-sanitize.min.js'
  './src/bower_components/angular-cookies/angular-cookies.min.js'
  './src/bower_components/angular-animate/angular-animate.min.js'
  './src/bower_components/angular-ui-router/release/angular-ui-router.min.js'
  './src/bower_components/angular-bootstrap/ui-bootstrap.min.js'
  './src/bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js'
  './src/bower_components/angularjs-slider/dist/rzslider.min.js'
  './src/bower_components/angulartics/dist/angulartics.min.js'
  './src/bower_components/angulartics-google-analytics/dist/angulartics-google-analytics.min.js'
  # './src/bower_components/angular-bootstrap-colorpicker/js/bootstrap-colorpicker-module.min.js'
  # './src/bower_components/angular-scroll/angular-scroll.min.js'
  './src/bower_components/zoom.js/dist/zoom.min.js'
  './src/bower_components/keen-js/dist/keen.min.js'
  # './src/bower_components/CUSTOM/fabric-custom.min.js'
]
sources.builderVendorUnmin = [
  './src/bower_components/fabric.js/dist/fabric.js'
  # TODO remove once cloudinary-core doesn't require lodash
  # './src/bower_components/lodash/lodash.js'
  # './src/bower_components/cloudinary-core/cloudinary-core.js'
  # './src/bower_components/cloudinary-jquery/cloudinary-jquery.js'
  # './src/bower_components/jquery/dist/jquery.js'
  './src/bower_components/jquery.ui/ui/widget.js'
  './src/bower_components/blueimp-file-upload/js/jquery.fileupload.js'
  './src/bower_components/blueimp-file-upload/js/jquery.iframe-transport.js'
  # './src/bower_components/blueimp-file-upload/js/jquery.fileupload-image.js'
  './src/bower_components/cloudinary-jquery-file-upload/cloudinary-jquery-file-upload.js'
  # TODO remove once zoom.js gone
  './src/bower_components/bootstrap/js/transition.js'
]

### MODULE ###
sources.appModule = [
  # Definitions
  './src/ee-shared/core/core.module.coffee'
  './src/ee-shared/core/constants.coffee'
  './src/ee-shared/core/filters.coffee'
  './src/ee-shared/core/config.coffee'
  './src/ee-shared/core/run.coffee'
  # Services
  './src/ee-shared/core/svc.modal.coffee'
]
sources.builderModule = [
  # Definitions
  './src/builder/builder.index.coffee'
  './src/builder/core/core.module.coffee'
  './src/builder/core/run.coffee'
  # Services
  './src/builder/core/svc.auth.coffee'
  './src/builder/core/svc.back.coffee'
  './src/builder/core/svc.definer.coffee'
  './src/builder/core/svc.cart.coffee'
  './src/builder/core/svc.user.coffee'
  './src/builder/core/svc.landing.coffee'
  # './src/builder/core/svc.template.coffee'
  # './src/builder/core/svc.templates.coffee'
  './src/builder/core/svc.product.coffee'
  './src/builder/core/svc.products.coffee'
  # './src/builder/core/svc.storeproduct.coffee'
  # './src/builder/core/svc.storeproducts.coffee'
  './src/builder/core/svc.collection.coffee'
  './src/builder/core/svc.collections.coffee'
  './src/builder/core/svc.categorizations.coffee'
  './src/builder/core/svc.customization.coffee'
  './src/builder/core/svc.orders.coffee'
  './src/builder/core/svc.track.coffee'
  './src/builder/core/svc.tracks.coffee'
  # Module - auth
  './src/builder/auth/auth.module.coffee'
  # auth.login
  './src/builder/auth.login/auth.login.route.coffee'
  './src/builder/auth.login/auth.login.controller.coffee'
  # auth.logout
  './src/builder/auth.logout/auth.logout.route.coffee'
  './src/builder/auth.logout/auth.logout.controller.coffee'
  # auth.reset
  './src/builder/auth.reset/auth.reset.route.coffee'
  './src/builder/auth.reset/auth.reset.controller.coffee'
  # Contact
  './src/builder/contact/contact.module.coffee'
  './src/builder/contact/contact.controller.coffee'
  # Module - landing
  './src/builder/landing/landing.module.coffee'
  './src/builder/landing/landing.route.coffee'
  './src/builder/landing/landing.controller.coffee'
  # Module - example
  './src/builder/example/example.module.coffee'
  './src/builder/example/example.route.coffee'
  './src/builder/example/example.controller.coffee'
  # Module - go
  './src/builder/go/go.module.coffee'
  './src/builder/go/go.route.coffee'
  './src/builder/go/go.controller.coffee'
  # Module - is
  './src/builder/is/is.module.coffee'
  './src/builder/is/is.route.coffee'
  './src/builder/is/is.controller.coffee'
  # Module - create
  './src/builder/create/create.module.coffee'
  './src/builder/create/create.route.coffee'
  './src/builder/create/create.controller.coffee'
  # Module - homepage
  './src/builder/homepage/homepage.module.coffee'
  './src/builder/homepage/homepage.route.coffee'
  './src/builder/homepage/homepage.controller.coffee'
  # './src/builder/homepage/edit.store.modal.controller.coffee'
  # './src/builder/homepage/edit.collection.modal.controller.coffee'
  # Module - settings
  './src/builder/settings/settings.module.coffee'
  './src/builder/settings/settings.route.coffee'
  './src/builder/settings/settings.controller.coffee'
  # Module - edit
  './src/builder/edit/edit.module.coffee'
  './src/builder/edit/edit.route.coffee'
  './src/builder/edit/edit.controller.coffee'
  # Module - promotions
  './src/builder/promotions/promotions.module.coffee'
  './src/builder/promotions/promotions.route.coffee'
  './src/builder/promotions/promotions.controller.coffee'
  # Module - terms
  './src/builder/terms/terms.module.coffee'
  './src/builder/terms/terms.route.coffee'
  './src/builder/terms/terms.controller.coffee'
  './src/builder/terms/terms.modal.controller.coffee'
  # Module - daily
  './src/builder/daily/daily.module.coffee'
  './src/builder/daily/daily.route.coffee'
  './src/builder/daily/daily.controller.coffee'
  # Module - tracks
  './src/builder/tracks/tracks.module.coffee'
  './src/builder/tracks/tracks.route.coffee'
  './src/builder/tracks/tracks.controller.coffee'
  './src/builder/tracks/track.controller.coffee'
  './src/builder/tracks/activity.modal.controller.coffee'
  # Module - start
  './src/builder/start/start.module.coffee'
  './src/builder/start/start.route.coffee'
  './src/builder/start/start.controller.coffee'
  # Module - brand
  './src/builder/brand/brand.module.coffee'
  './src/builder/brand/brand.route.coffee'
  './src/builder/brand/brand.controller.coffee'
  # Module - date
  './src/builder/date/date.module.coffee'
  './src/builder/date/date.route.coffee'
  './src/builder/date/date.controller.coffee'
  # Module - storefront
  './src/builder/storefront/storefront.module.coffee'
  './src/builder/storefront/storefront.route.coffee'
  './src/builder/storefront/storefront.controller.coffee'
  # Module - products
  './src/builder/products/products.module.coffee'
  './src/builder/products/products.route.coffee'
  './src/builder/products/products.controller.coffee'
  './src/builder/products/product.controller.coffee'
  './src/builder/products/product.modal.controller.coffee'
  # Module - collections
  './src/builder/collections/collections.module.coffee'
  './src/builder/collections/collections.route.coffee'
  './src/builder/collections/collections.controller.coffee'
  './src/builder/collections/collection.controller.coffee'
  # './src/builder/collections/collection.products.modal.controller.coffee'
  # Module - categorizations
  './src/builder/categorizations/categorizations.module.coffee'
  './src/builder/categorizations/categorizations.route.coffee'
  './src/builder/categorizations/categorizations.controller.coffee'
  # Module - orders
  './src/builder/orders/orders.module.coffee'
  './src/builder/orders/orders.route.coffee'
  './src/builder/orders/orders.controller.coffee'
  # Module - account
  './src/builder/account/account.module.coffee'
  './src/builder/account/account.route.coffee'
  './src/builder/account/account.controller.coffee'
  # Module - live
  './src/builder/live/live.module.coffee'
  './src/builder/live/live.route.coffee'
  './src/builder/live/live.controller.coffee'
]

### DIRECTIVES ###
sources.builderDirective = [
  # TODO remove seller & privacy directives
  './src/components/ee-terms-seller.coffee'
  './src/components/ee-terms-privacy.coffee'
  './src/components/ee-builder-navbar.coffee'
  './src/components/ee-builder-live-button.coffee'
  './src/components/ee-builder-section-heading.coffee'
  './src/components/ee-product-builder-buttons.coffee'
  './src/components/ee-product-for-builder.coffee'
  './src/components/ee-price-editor.coffee'
  './src/components/ee-collection-for-builder.coffee'
  './src/components/ee-save.coffee'
  './src/components/ee-cloudinary-upload.coffee'
  './src/components/ee-zendesk.coffee'
  './src/components/ee-web-colorpicker.coffee'
  './src/components/ee-font-selector.coffee'
  './src/components/ee-builder-activity.coffee'
  './src/components/ee-builder-track-nav.coffee'
  # './src/components/ee-image-layer-editor.coffee' # TODO remove once ee-layers is finished
  # './src/components/ee-layers.coffee'
  './src/components/ee-canvas.coffee'
  './src/components/ee-unsplash-search.coffee'
  './src/components/ee-guide-button.coffee'
  './src/components/ee-collection-carousel.coffee'
]
sources.sharedDirective = [
  './src/ee-shared/components/ee-product-card.coffee'
  './src/ee-shared/components/ee-product-for-store.coffee'
  './src/ee-shared/components/ee-products-in-collection.coffee'
  './src/ee-shared/components/ee-product-images.coffee'
  './src/ee-shared/components/ee-collection-for-store.coffee'
  './src/ee-shared/components/ee-collection-image-preview.coffee'
  './src/ee-shared/components/ee-loading.coffee'
  './src/ee-shared/components/ee-collection-nav.coffee'
  './src/ee-shared/components/ee-order.coffee'
  './src/ee-shared/components/ee-image-preload.coffee'
  './src/ee-shared/components/ee-storefront-header.coffee'
  './src/ee-shared/components/ee-storefront-scroller.coffee'
  './src/ee-shared/components/ee-storefront-brand.coffee'
  './src/ee-shared/components/ee-scroll-to-top.coffee'
  './src/ee-shared/components/ee-empty-message.coffee'
  './src/ee-shared/components/ee-datepicker.coffee'
]

module.exports = sources
