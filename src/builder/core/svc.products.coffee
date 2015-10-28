'use strict'

angular.module('builder.core').factory 'eeProducts', ($rootScope, $q, eeBack, eeAuth, eeModal, eeElasticsearch) ->

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
      { id: 1, title: 'Artwork' },
      { id: 2, title: 'Bed & Bath' },
      { id: 3, title: 'Furniture' },
      { id: 4, title: 'Home Accents' },
      { id: 5, title: 'Kitchen' },
      { id: 6, title: 'Outdoor' }
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
    featured:
      count:        null
      products:     []
      inputs:       angular.copy _inputDefaults
      reading:    false
    categories:
      count:        null
      products:     []
      inputs:       angular.copy _inputDefaults
      reading:    false
    search:
      count:        null
      products:     []
      category_ids: []
      inputs:       angular.copy _inputDefaults
      reading:    false
      lastCollectionAddedTo: null

  ## PRIVATE FUNCTIONS
  _clearSection = (section) ->
    _data[section].products = []
    _data[section].count    = 0

  _formQuery = (section) ->
    query = {}
    query.size = _data[section].inputs.perPage
    if section is 'featured'            then query.feat       = 'true'
    # if section is 'categories'          then query.cust       = 'true'
    if _data[section].inputs.page       then query.page       = _data[section].inputs.page
    if _data[section].inputs.range.min  then query.min_price  = _data[section].inputs.range.min
    if _data[section].inputs.range.max  then query.max_price  = _data[section].inputs.range.max
    if _data[section].inputs.search     then query.search     = _data[section].inputs.search
    if _data[section].category_ids?.length > 0 then query.category_ids = _data[section].category_ids
    query

  _runQuery = (section, queryPromise) ->
    if !!_data[section].reading then return
    _data[section].reading = true
    queryPromise
    .then (res) ->
      { rows, count, took } = res
      _data[section].products = rows
      _data[section].count    = count
      _data[section].took     = took
      _data[section].inputs.searchLabel = _data[section].inputs.search
    .catch (err) -> _data[section].count = null
    .finally () -> _data[section].reading = false

  _runSection = (section) ->
    switch section
      when 'featured'   then _runQuery 'featured',   eeBack.fns.searchFeatured(eeAuth.fns.getToken(), _formQuery('featured'))
      when 'categories' then _runQuery 'categories', eeElasticsearch.fns.searchProducts(eeAuth.fns.getToken(), _formQuery('categories'))
      when 'search'     then _runQuery 'search',     eeElasticsearch.fns.searchProducts(eeAuth.fns.getToken(), _formQuery('search'))

  _searchWithTerm = (term) ->
    _data.search.inputs.search = term
    _data.search.inputs.page = 1
    _runSection 'search'

  _addCategory = (category) ->
    _data.search.category_ids.push category.id

  _removeCategory = (category) ->
    new_category_ids = []
    (if cat_id isnt category.id then new_category_ids.push cat_id) for cat_id in _data.search.category_ids
    _data.search.category_ids = new_category_ids

  _addProductModal = (product) ->
    product.err = null
    _data.search.productToAdd = {}
    _data.search.productToAdd = product
    eeModal.fns.open 'addProduct'
    return

  ## MESSAGING
  # $rootScope.$on 'reset:products', () -> _data.search.products = []
  #
  # $rootScope.$on 'added:product', (e, product, collection_id) ->
  #   _data.search.lastCollectionAddedTo = collection_id
  #   (if product.id is prod.id then prod.productId = product.productId) for prod in _data.search.products
  #   eeModal.fns.close('addProduct')

  ## EXPORTS
  data: _data
  fns:
    runSection: _runSection
    search: _searchWithTerm
    clearSearch: () -> _searchWithTerm ''
    toggleCategory: (category) ->
      _data.search.inputs.page = 1
      if _data.search.category_ids.indexOf(category.id) < 0 then _addCategory(category) else _removeCategory(category)
      _runSection 'search'
    setRange: (range) ->
      range = range || {}
      _data.search.inputs.page = 1
      if _data.search.inputs.range.min is range.min and _data.search.inputs.range.max is range.max
        _data.search.inputs.range.min = null
        _data.search.inputs.range.max = null
      else
        _data.search.inputs.range.min = range.min
        _data.search.inputs.range.max = range.max
      _runSection 'search'
    addProductModal: _addProductModal

    featured: () ->
      _clearSection 'featured'
      console.log '/featured'
      # _data.featured = true
      # _data.page = 1
      # _runSection 'featured'
      {}
