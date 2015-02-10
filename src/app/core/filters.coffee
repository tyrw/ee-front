'use strict'

angular.module('app.core').filter 'eeShopCategories', () ->
  (products, category) ->
    if !products or !category or category is 'All' then return products
    filtered = []
    for product in products
      # TODO implement custom categories
      # if product.categories?.indexOf(category) >= 0 then filtered.push product
      if product.category is category then filtered.push product
    return filtered

angular.module('app.core').filter 'centToDollar', ($filter) ->
  (cents) ->
    currencyFilter = $filter('currency')
    currencyFilter Math.floor(cents)/100

angular.module('app.core').filter 'thumbnail', () ->
  (url) -> url.split("image/upload").join('image/upload/c_pad,w_150,h_150')

angular.module('app.core').filter 'urlText', () ->
  (text) -> text.replace(/[^a-zA-Z0-9_]/gi, '').toLowerCase()
