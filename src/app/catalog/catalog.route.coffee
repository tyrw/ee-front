'use strict'

angular.module('app.catalog').config ($stateProvider, $locationProvider) ->
  $locationProvider.html5Mode true

  $stateProvider.state 'app.catalog',
    url: '/catalog'
    templateUrl: 'partials/app/catalog.html'
    controller: 'app.catalogCtrl'
    # resolve: eeProductData: (eeBack) -> eeBack.getProducts()
    data:
      pageTitle: 'Add products | eeosk'
      offscreenCategory: 'Catalog'
      offscreenColor: 'gold'
