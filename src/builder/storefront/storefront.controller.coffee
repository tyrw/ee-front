'use strict'

angular.module('builder.storefront').controller 'storefrontCtrl', ($state, eeDefiner, eeUser, eeCollection, eeCollections, eeProducts, eeModal) ->

  storefront = this

  storefront.ee       = eeDefiner.exports
  storefront.state    = $state.current.name
  storefront.openCollectionsModal = () -> eeModal.fns.openCollectionsModal(eeCollections.data.nav.alphabetical)
  storefront.productsUpdate  = () -> eeProducts.fns.update()

  eeUser.fns.defineUser()
  .then () ->
    return unless storefront.ee?.User?.user?.storefront_meta?
    storefront.ee.meta      = storefront.ee.User.user.storefront_meta
    storefront.ee.carousel  = storefront.ee.User.user.storefront_meta.home.carousel[0]

  eeCollections.fns.defineNavCollections()
  eeProducts.fns.featured()

  return
