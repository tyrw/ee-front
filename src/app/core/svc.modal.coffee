'use strict'

angular.module('app.core').factory 'eeModal', ($modal) ->

  ## SETUP
  _modals         = {}
  _backdropClass  = 'white-background opacity-08'

  _config =
    login:
      templateUrl:    'builder/auth.login/auth.login.modal.html'
      controller:     'loginCtrl as modal'
      size:           'sm'
      backdropClass:  _backdropClass
    signup:
      templateUrl:    'builder/auth.signup/auth.signup.modal.html'
      controller:     'signupCtrl as modal'
      size:           'sm'
      backdropClass:  _backdropClass
    sellerTerms:
      templateUrl:    'builder/terms/terms.modal.html'
      controller:     'termsModalCtrl as modal'
      backdropClass:  _backdropClass
    privacyPolicy:
      templateUrl:    'builder/terms/terms.modal.privacy.html'
      controller:     'termsModalCtrl as modal'
      backdropClass:  _backdropClass

  ## PRIVATE FUNCTIONS
  _open = (name) ->
    if !name or !_config[name] then return
    _modals[name] = $modal.open _config[name]
    return

  _close = (name) ->
    if !_modals[name] then return
    _modals[name].close()
    return

  ## EXPORTS
  fns:

    openLoginModal:         () -> _open 'login'
    openSignupModal:        () -> _open 'signup'
    openSellerTermsModal:   () -> _open 'sellerTerms'
    openPrivacyPolicyModal: () -> _open 'privacyPolicy'

    closeLoginModal:        () -> _close 'login'