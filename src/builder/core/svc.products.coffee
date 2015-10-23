'use strict'

angular.module('builder.core').factory 'eeProducts', ($rootScope, $q, eeBack, eeAuth, eeDefiner, eeModal, eeElasticsearch) ->

  ## SETUP
  _inputDefaults =
    perPage:          48
    page:             null
    search:           null
    searchLabel:      null
    range:
      min:            null
      max:            null
    category:         null
    categoryArray: [
      'Artwork'
      'Bed & Bath'
      'Furniture'
      'Home Accents'
      'Kitchen'
      'Outdoor'
    ]
    rangeArray: [
      { min: 0,     max: 2500   },
      { min: 2500,  max: 5000   },
      { min: 5000,  max: 10000  },
      { min: 10000, max: 20000  },
      { min: 20000, max: null   }
    ]

  ## PRIVATE EXPORT DEFAULTS
  _data =
    count:      null
    products:   []
    inputs:     _inputDefaults
    searching:  false
    lastCollectionAddedTo: null

  ## PRIVATE FUNCTIONS
  _formQuery = () ->
    query = {}
    query.size = _data.inputs.perPage
    if _data.inputs.page      then query.page       = _data.inputs.page
    if _data.inputs.range.min then query.min_price  = _data.inputs.range.min
    if _data.inputs.range.max then query.max_price  = _data.inputs.range.max
    if _data.inputs.search    then query.search     = _data.inputs.search
    if _data.inputs.category  then query.categories = [ _data.inputs.category ] else query.categories = []
    query

  _runQuery = () ->
    deferred = $q.defer()
    if !!_data.searching then return _data.searching
    _data.searching = deferred.promise
    eeElasticsearch.fns.searchProducts eeAuth.fns.getToken(), _formQuery()
    .then (res) ->
      { hits, total } = res.hits
      console.log 'res', res
      _data.count    = total
      _data.products = hits
      _data.inputs.searchLabel = _data.inputs.search
      deferred.resolve _data.products
    .catch (err) ->
      _data.count = null
      deferred.reject err
    .finally () ->
      _data.searching = false
    deferred.promise

  _addProductModal = (product) ->
    product.err = null
    _data.productToAdd = {}
    _data.productToAdd = product
    eeModal.fns.open('addProduct')

  ## MESSAGING
  # $rootScope.$on 'reset:products', () -> _data.products = []
  #
  # $rootScope.$on 'added:product', (e, product, collection_id) ->
  #   _data.lastCollectionAddedTo = collection_id
  #   (if product.id is prod.id then prod.storeProductId = product.storeProductId) for prod in _data.products
  #   eeModal.fns.close('addProduct')

  ## EXPORTS
  data: _data
  fns:
    update: () -> _runQuery()
    search: () ->
      _data.inputs.page = 1
      _runQuery()
    clearSearch: () ->
      _data.inputs.search = ''
      _data.inputs.page = 1
      _runQuery()
    # incrementPage: () ->
    #   _data.inputs.page = if _data.inputs.page < 1 then 2 else _data.inputs.page + 1
    #   _runQuery()
    # decrementPage: () ->
    #   _data.inputs.page = if _data.inputs.page < 2 then 1 else _data.inputs.page - 1
    #   _runQuery()
    setCategory: (category) ->
      _data.inputs.page = 1
      _data.inputs.category = if _data.inputs.category is category then null else category
      _runQuery()
    setRange: (range) ->
      range = range || {}
      _data.inputs.page = 1
      if _data.inputs.range.min is range.min and _data.inputs.range.max is range.max
        _data.inputs.range.min = null
        _data.inputs.range.max = null
      else
        _data.inputs.range.min = range.min
        _data.inputs.range.max = range.max
      _runQuery()
    addProductModal: _addProductModal
