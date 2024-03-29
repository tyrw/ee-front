'use strict'

angular.module('builder.core').factory 'eeTemplates', ($rootScope, $q, eeBack, eeAuth, eeDefiner, eeModal) ->

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
    templates:  []
    inputs:     _inputDefaults
    searching:  false
    lastCollectionAddedTo: null

  ## PRIVATE FUNCTIONS
  _formQuery = () ->
    query = {}
    if _data.inputs.page      then query.page       = _data.inputs.page
    if _data.inputs.range.min then query.min        = _data.inputs.range.min
    if _data.inputs.range.max then query.max        = _data.inputs.range.max
    if _data.inputs.search    then query.search     = _data.inputs.search
    if _data.inputs.category  then query.categories = [ _data.inputs.category ] else query.categories = []
    query

  _runQuery = () ->
    deferred = $q.defer()
    if !!_data.searching then return _data.searching
    _data.searching = deferred.promise
    eeBack.fns.templatesGET eeAuth.fns.getToken(), _formQuery()
    .then (res) ->
      { count, rows } = res
      _data.count     = count
      _data.templates = rows
      _data.inputs.searchLabel = _data.inputs.search
      deferred.resolve _data.templates
    .catch (err) ->
      _data.count = null
      deferred.reject err
    .finally () ->
      _data.searching = false
    deferred.promise

  _addTemplateModal = (template) ->
    template.err = null
    _data.templateToAdd = {}
    _data.templateToAdd = template
    eeModal.fns.open('addTemplate')

  ## MESSAGING
  $rootScope.$on 'reset:templates', () -> _data.templates = []

  $rootScope.$on 'added:template', (e, template, collection_id) ->
    _data.lastCollectionAddedTo = collection_id
    (if template.id is prod.id then prod.productId = template.productId) for prod in _data.templates
    eeModal.fns.close('addTemplate')

  # $rootScope.$on 'removed:product', (e, data) ->
  #   (if data.id is product.template_id then template.productId = null) for template in _data.templates

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
    incrementPage: () ->
      _data.inputs.page = if _data.inputs.page < 1 then 2 else _data.inputs.page + 1
      _runQuery()
    decrementPage: () ->
      _data.inputs.page = if _data.inputs.page < 2 then 1 else _data.inputs.page - 1
      _runQuery()
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
    addTemplateModal: _addTemplateModal
