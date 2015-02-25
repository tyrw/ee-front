'use strict'

angular.module('app.storefront').controller 'app.storefrontRootCtrl', ($scope, $rootScope, user, eeStorefront) ->
  $rootScope.toggle = true
  $scope.user = user

  eeStorefront.setScopeStorefront($scope)
  $rootScope.$on 'storefront:updated', (e, storefront) -> $scope.storefront = storefront

  return

angular.module('app.storefront').controller 'app.storefrontChildCtrl', ($scope, $state, eeAuth) ->
  if $state.current.name is 'app.storefront.shop_redirect' then $state.go 'app.storefront.shop', shopCategory: 'All'
  return
