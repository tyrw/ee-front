'use strict'

angular.module('builder.core').factory 'eeBack', ($http, $q, eeBackUrl) ->

  _data =
    requesting: false
    requestingArray: []

  _handleError = (deferred, data, status) ->
    if status is 0 then deferred.reject 'Connection error' else deferred.reject data

  _setRequesting = () -> _data.requesting = _data.requestingArray.length > 0

  _startRequest = () ->
    _data.requestingArray.push 'r'
    _setRequesting()

  _endRequest = () ->
    _data.requestingArray.pop()
    _setRequesting()

  _makeRequest = (req) ->
    _startRequest()
    deferred = $q.defer()
    $http(req)
      .success (data, status) -> deferred.resolve data
      .error (data, status) -> _handleError deferred, data, status
      .finally () -> _endRequest()
    deferred.promise

  _formQueryString = (query) ->
    if !query then return ''
    keys = Object.keys(query)
    parts = []
    addQuery = (key) -> parts.push(encodeURIComponent(key) + '=' + encodeURIComponent(query[key]))
    addQuery(key) for key in keys
    '?' + parts.join('&')

  data: _data
  fns:

    tokenPOST: (token) ->
      _makeRequest {
        method: 'POST'
        url: eeBackUrl + 'token'
        headers: authorization: token
      }

    authPOST: (email, password) ->
      _makeRequest {
        method: 'POST'
        url: eeBackUrl + 'auth'
        headers: authorization: 'Basic ' + email + ':' + password
      }

    goPOST: (token) ->
      _makeRequest {
        method: 'POST'
        url: eeBackUrl + 'go'
        data: { token: token }
      }

    createTokenPOST: (token) ->
      _makeRequest {
        method: 'POST'
        url: eeBackUrl + 'create'
        data: { token: token }
      }

    passwordResetEmailPOST: (email) ->
      _makeRequest {
        method: 'POST'
        url: eeBackUrl + 'password_reset_email'
        headers: {}
        data: { email: email }
      }

    usersGET: (token) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'users'
        headers: authorization: token
      }

    usersPUT: (user, token) ->
      _makeRequest {
        method: 'PUT'
        url: eeBackUrl + 'users'
        headers: authorization: token
        data: user
      }

    usersPOST: (email, proposition) ->
      _makeRequest {
        method: 'POST'
        url: eeBackUrl + 'users'
        headers: {}
        data:
          email: email
          proposition: proposition
      }

    usersUpdatePasswordPUT: (password, token) ->
      _makeRequest {
        method: 'PUT'
        url: eeBackUrl + 'users_update_password'
        headers: authorization: token
        data: { password: password }
      }

    usersUpdateEmailPUT: (email, token) ->
      _makeRequest {
        method: 'PUT'
        url: eeBackUrl + 'users_update_email'
        headers: authorization: token
        data: { email: email }
      }

    usersCompletePUT: (data, token) ->
      _makeRequest {
        method: 'PUT'
        url: eeBackUrl + 'complete'
        headers: authorization: token
        data: data
      }

    usersStorefrontGET: (token, collection) ->
      path = 'storefront'
      if collection then path += '/' + collection
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + path
        headers: authorization: token
      }

    storefrontGET: (username) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'storefront/' + username + '/all'
        headers: authorization: {}
      }

    collectionPOST: (data, token) ->
      _makeRequest {
        method: 'POST'
        url: eeBackUrl + 'collections'
        headers: authorization: token
        data: data
      }

    collectionClonePOST: (id, token) ->
      _makeRequest {
        method: 'POST'
        url: eeBackUrl + 'collections/clone/' + id
        headers: authorization: token
      }

    collectionGET: (id, token, query) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'collections/' + id + _formQueryString(query)
        headers: authorization: token
      }

    collectionPublicGET: (id, token, query) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'collections/' + id + '/public' + _formQueryString(query)
        headers: authorization: token
      }

    collectionPUT: (data, token) ->
      _makeRequest {
        method: 'PUT'
        url: eeBackUrl + 'collections/' + data.id
        headers: authorization: token
        data: data
      }

    collectionDELETE: (id, token) ->
      _makeRequest {
        method: 'DELETE'
        url: eeBackUrl + 'collections/' + id
        headers: authorization: token
      }

    collectionAddProduct: (collection_id, product_id, token) ->
      _makeRequest {
        method: 'PUT'
        url: eeBackUrl + 'collections/' + collection_id + '/add/' + product_id
        headers: authorization: token
      }

    collectionRemoveProduct: (collection_id, product_id, token) ->
      _makeRequest {
        method: 'PUT'
        url: eeBackUrl + 'collections/' + collection_id + '/remove/' + product_id
        headers: authorization: token
      }

    collectionsGET: (token, query) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'collections' + _formQueryString(query)
        headers: authorization: token
      }

    collectionsNavGET: (token) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'collections/nav'
        headers: authorization: token
      }

    categorizationsGET: (token) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'categorizations'
        headers: authorization: token
      }

    # productsSEARCH: (token, query) ->
    #   _makeRequest {
    #     method: 'GET'
    #     url: eeBackUrl + 'products' + _formQueryString(query)
    #     headers: authorization: token
    #   }

    productsGET: (token, query) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'products' + _formQueryString(query)
        headers: authorization: token
      }

    productGET: (id, token) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'products/' + id
        headers: authorization: token
      }

    productsPUT: (data, token) ->
      _makeRequest {
        method: 'PUT'
        url: eeBackUrl + 'products/' + data.id
        headers: authorization: token
        data: data
      }

    productsDELETE: (id, token) ->
      _makeRequest {
        method: 'DELETE'
        url: eeBackUrl + 'products/' + id
        headers: authorization: token
      }

    customizationsPOST: (data, token) ->
      _makeRequest {
        method: 'POST'
        url: eeBackUrl + 'customizations'
        headers: authorization: token
        data: data
      }

    ordersGET: (token) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'orders'
        headers: authorization: token
      }

    contactPOST: (name, email, message) ->
      _makeRequest {
        method: 'POST'
        url: eeBackUrl + 'contact'
        data: { name: name, email: email, message: message }
      }

    tracksGET: (token, query) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'tracks' + _formQueryString(query)
        headers: authorization: token
      }

    trackGET: (id, token) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'tracks/' + id
        headers: authorization: token
      }

    dailyActivityGET: (token) ->
      _makeRequest {
        method: 'GET'
        url: eeBackUrl + 'activities/random'
        headers: authorization: token
      }
