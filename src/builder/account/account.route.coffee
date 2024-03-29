'use strict'

angular.module('builder.account').config ($stateProvider) ->

  $stateProvider
    .state 'account',
      url: '/account'
      views:
        header:
          controller:  'accountCtrl as account'
          templateUrl: 'builder/account/account.header.html'
        top:
          controller:  'accountCtrl as account'
          templateUrl: 'builder/account/account.html'
      data:
        pageTitle: 'Account | eeosk'
        padTop:    '120px'

    .state 'earnings',
      url: '/earnings'
      views:
        header:
          controller:  'accountCtrl as account'
          templateUrl: 'builder/account/account.header.html'
        top:
          controller:  'accountCtrl as account'
          templateUrl: 'builder/account/account.earnings.html'
      data:
        pageTitle: 'Earnings | eeosk'
        padTop:    '120px'

    .state 'referrals',
      url: '/referrals'
      views:
        header:
          controller:  'accountCtrl as account'
          templateUrl: 'builder/account/account.header.html'
        top:
          controller:  'accountCtrl as account'
          templateUrl: 'builder/account/account.referrals.html'
      data:
        pageTitle: 'Referrals | eeosk'
        padTop:    '120px'

  return
