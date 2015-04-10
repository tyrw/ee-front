'use strict'

angular.module('builder.example').config ($stateProvider, $locationProvider) ->

  $stateProvider
    .state 'example',
      url: '/example'
      views:
        top:
          controller: 'landingCtrl'
          templateUrl: 'builder/landing/landing.html'
        bottom:
          controller: 'exampleCtrl'
          templateUrl: 'builder/example/example.html'
      data:
        pageTitle:        'Demo Store | eeosk'
        pageDescription:  'An example of what\'s possible on eeosk.'

  return