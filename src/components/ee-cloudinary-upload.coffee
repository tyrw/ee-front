'use_strict'

$.cloudinary.config({ cloud_name: 'eeosk' })

angular.module 'ee-cloudinaryUpload', []

angular.module('ee-cloudinaryUpload').directive "eeCloudinaryUpload", ($rootScope) ->
  templateUrl: 'components/ee-cloudinary-upload.html'
  restrict: 'E'
  replace: true
  scope:
    meta: '='
    attrTarget: '='
  link: (scope, element, attrs) ->
    form = element
    cloudinary_transform = 'storefront_home'
    if scope.attrTarget is 'logo'       then cloudinary_transform = 'logo_300x80'
    if scope.attrTarget is '1000x1000'  then cloudinary_transform = 'limit_1000x1000'
    if scope.attrTarget is 'canvas'     then cloudinary_transform = 'width_800'
    if scope.attrTarget is 'collection' then cloudinary_transform = 'banner'

    form
      .append($.cloudinary.unsigned_upload_tag cloudinary_transform, {
          cloud_name: 'eeosk',
          tags: 'browser_uploads'
        })

    assignAttr = (data) ->
      if scope.attrTarget is 'about'  then scope.meta.about.imgUrl  = data.result.secure_url
      if scope.attrTarget is 'logo'   then scope.meta.brand.image   =  { logo: data.result.secure_url }
      $rootScope.$broadcast 'cloudinary:finished', { url: data.result.secure_url, target: scope.attrTarget }

    resetProgress = () ->
      scope.progress = 0
      scope.partialProgress = 3

    bindCloudinary = () ->
      form
        .bind 'cloudinarydone', (e, data) ->
          resetProgress()
          unbindCloudinary()
          assignAttr(data)
          scope.$apply()
          $rootScope.$broadcast 'cloudinaryUploadFinished'
          bindCloudinary()
        .bind 'cloudinaryprogress', (e, data) ->
          percentage = Math.round((data.loaded * 100.0) / data.total)
          # Only scope.$apply periodically
          if percentage > scope.partialProgress
            scope.partialProgress = percentage + 3
            scope.progress = if scope.progress > 99 then 0 else percentage
            scope.$apply()

      unbindCloudinary = () ->
        form.unbind 'cloudinaryprogress'
        form.unbind 'cloudinarydone'

    resetProgress()
    bindCloudinary()
    return
