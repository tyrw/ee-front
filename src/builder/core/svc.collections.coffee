'use strict'

angular.module('builder.core').factory 'eeCollections', ($q, $rootScope, eeAuth, eeBack) ->

  ## SETUP
  # none

  ## PRIVATE EXPORT DEFAULTS
  _data =
    creating:         false
    reading:          false
    updating:         false
    destroying:       false
    count:            null
    page:             null
    perPage:          24
    collections:      []
    featured:
      reading:        false
      updating:       false
      count:          null
      page:           null
      perPage:        48
      collection:     {}
      storeProducts:  []
    firstTenCollections: []
    afterTenCollections: []
    carouselCollections: []
    public:
      reading:        false
      count:          null
      page:           null
      perPage:        24
      collections:    []

  _dummies = [
    {
      title: 'nautical'
      headline: 'Your inner sailor'
      button: 'Shop nautical'
      banner: 'https://res.cloudinary.com/eeosk-team/image/upload/c_fill,h_480,w_840/v1436838757/excellent-nautical-living-room-on-living-room-at-nautical-living-room_ogpruo.png'
      min_price: 2299
      max_price: 14499
      avg_price: 7888
      avg_earnings: 671
      max_sale: 25
      product_images: [
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891015/rvsmsaz5szbqwdjjulva.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891094/hpvkacccur0hsyxxqa6w.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891109/o3nqomb4gnr06ku4xcja.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891143/xxdqhbwzblajuyobslmg.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891265/wigd1gph1cr7qzg8vado.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891144/xgjl1sfsk2w0qmliqc8j.jpg'
      ]
      product_ids: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
    },
    {
      title: 'fun_bedding'
      headline: 'Back to school bedding'
      button: 'See the colors'
      banner: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,h_480,w_840/v1429115091/lanxaprcneyjq4d7syqo.jpg'
      min_price: 9699
      max_price: 12799
      avg_price: 10282
      avg_earnings: 1239
      max_sale: 20
      product_images: [
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115063/c5smhguzidlq0edp0hkl.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115066/bzzfimkhntulfg2d8tc5.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115088/dfqbo0nwlb2zao5sxyxz.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115065/eyiz2pydn6jt6kz3ssu6.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115063/puawmj0mwflmuaogcdve.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115064/pzdnnrexpj4s1ygrosu3.jpg'
      ]
      product_ids: [1,2,3,4,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
    },
    {
      title: 'water_scenes'
      headline: 'Art on the water'
      button: 'Shop now'
      banner: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,h_480,w_840/v1429114970/emhbhfxmxu5fmbykilvk.jpg'
      min_price: 3799
      max_price: 17999
      avg_price: 11423
      avg_earnings: 1442
      max_sale: 33
      product_images: [
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115002/avseisxqbkyb4rj3qflx.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115004/oeeorcegmq1ouigksdik.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115009/sxlj3cziot82csxy96ks.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429114975/psmyun8qtzkdula8oj32.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429114976/bzdetxgangjpehyokwtg.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115003/tvyzj99qjsnnnokz6pkk.jpg'
      ]
      product_ids: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46]
    },
    {
      title: 'wood_grains'
      headline: 'Stylish wood grain furniture'
      button: 'Shop now'
      banner: 'https://res.cloudinary.com/eeosk-team/image/upload/c_pad,h_480,w_840/v1436838480/woodgrain_si5h6f.jpg'
      min_price: 4599
      max_price: 18999
      avg_price: 8875
      avg_earnings: 981
      max_sale: 25
      product_images: [
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115276/kozoqbnvdsb4jcojep0n.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115621/b16fmnjuafl5nz52uhya.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891036/hfcrlb2ztpotuifdeyxt.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115168/y3d9v5u3pmzyoaes3yco.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891009/ynwmhdf3baduehpnj3k4.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891127/ufp1crprwaovggxcyv17.jpg'
      ]
      product_ids: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56]
    },
    {
      title: 'house_plaque_letters'
      headline: 'House Plaque Letters A-Z'
      button: 'Find your letter!'
      banner: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,h_480,w_840/v1429115273/xcclhkjyeuqutfhnipyg.jpg'
      min_price: 3999
      max_price: 3999
      avg_price: 3999
      avg_earnings: 811
      max_sale: 33
      product_images: [
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115271/rydpfgsabx8hj8ec2grf.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115271/e7m0q8hqcpvchwtnsxok.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115271/vj7bf01uinmjkydxisxw.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115271/v6enqlhh37zxcdcrkyj8.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115271/lcuekbazsuud9rxgqqzk.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115271/tfzqtiiif3oowqmszemf.jpg'
      ]
      product_ids: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]
    },
    {
      title: 'office_containers'
      headline: 'Sip at your office in style'
      button: 'Shop now'
      banner: 'https://res.cloudinary.com/eeosk-team/image/upload/c_fill,h_480,w_840/v1436889209/stock-footage-happy-businesswoman-drinking-coffee-in-the-office_klv8is.jpg'
      min_price: 799
      max_price: 2799
      avg_price: 928
      avg_earnings: 213
      max_sale: 10
      product_images: [
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115618/ofiqzxf5kpxslmpr0aph.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891213/yhdt8ghbcs33lxm5tb7l.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115610/f55oakqbp0f9ukjsarfp.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891204/vmiyhr2orynd5trgqvyr.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115613/olzjjwvq5hhwle3pfm4p.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1433891205/lkpp7esvjbjg4bozwzcx.jpg'
      ]
      product_ids: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]
    },
    {
      title: 'ceramic_figurines'
      headline: 'Delightful ceramic figurines'
      button: 'Shop now'
      banner: 'https://res.cloudinary.com/eeosk/image/upload/c_pad,h_480,w_840/v1429115327/mrrnhwh5ovxfemvvbgw0.jpg'
      min_price: 3599
      max_price: 5599
      avg_price: 4291
      avg_earnings: 921
      max_sale: 15
      product_images: [
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115321/i95jpntagm0pwbbrvvjh.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115322/x1va1hei1xg5m5hexuv2.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115320/rwmc0zaml6uqxdig2ko7.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115324/v9tuzcuhhaukfxaqd29v.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115338/vnq2mddxflbske5dotu0.jpg',
        'https://res.cloudinary.com/eeosk/image/upload/c_pad,w_70,h_70/v1429115330/xwfzsxgbh6mn9aln07b8.jpg'
      ]
      product_ids: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33]
    }
  ]

  ## PRIVATE FUNCTIONS

  _resetCollections = () ->
    _data.collections = []
    _data.firstTenCollections = []
    _data.public.collections = []

  _setFirstTenCollections = () ->
    _data.firstTenCollections = []
    _data.afterTenCollections = []
    _data.carouselCollections = []
    setCollection = (coll) ->
      return unless coll.title
      if _data.firstTenCollections?.length < 10 then _data.firstTenCollections.push coll else _data.afterTenCollections.push coll
      if _data.carouselCollections?.length < 10 and coll.in_carousel and coll.banner.indexOf('placehold.it') is -1 then _data.carouselCollections.push coll
    setCollection collection for collection in _data.collections

  _createCollection = () ->
    deferred  = $q.defer()
    token     = eeAuth.fns.getToken()
    if _data.creating then return _data.creating
    if !token then deferred.reject('Missing token'); return deferred.promise
    _data.creating = deferred.promise
    eeBack.collectionsPOST token
    .then (collection) ->
      $rootScope.$broadcast 'sync:collections', collection
      collection
    .catch (err) -> console.error err
    .finally () -> _data.creating = false

  _readPublicCollections = () ->
    deferred  = $q.defer()
    token     = eeAuth.fns.getToken()
    if _data.public.reading then return _data.public.reading
    if !token then deferred.reject('Missing token'); return deferred.promise
    _data.public.reading = deferred.promise
    eeBack.publicCollectionsGET token
    .then (res) ->
      _data.page                = 1
      _data.public.collections  = _dummies # res.rows
      _data.public.count        = res.count
    .finally () -> _data.public.reading = false

  _readOwnCollections = () ->
    deferred  = $q.defer()
    token     = eeAuth.fns.getToken()
    if _data.reading then return _data.reading
    if !token then deferred.reject('Missing token'); return deferred.promise
    _data.reading = deferred.promise
    eeBack.ownCollectionsGET token
    .then (res) ->
      _data.page        = 1
      _data.collections = res.rows
      _data.count       = res.count
      _setFirstTenCollections()
    .catch (err) -> console.error err
    .finally () -> _data.reading = false

  # _readFeaturedCollection = () ->
  #   deferred  = $q.defer()
  #   token     = eeAuth.fns.getToken()
  #   if _data.featured.reading then return _data.featured.reading
  #   if !token then deferred.reject('Missing token'); return deferred.promise
  #   _data.featured.reading = deferred.promise
  #   eeBack.featuredCollectionGET token
  #   .then (res) ->
  #     { page, count, perPage, collection, storeProducts } = res
  #     _data.featured.page          = page
  #     _data.featured.perPage       = perPage
  #     _data.featured.count         = count
  #     _data.featured.collection    = collection
  #     _data.featured.storeProducts = storeProducts
  #   .catch (err) -> console.error err
  #   .finally () -> _data.featured.reading = false

  _definePublicCollections = (force) ->
    $q.when(if !_data.public.collections or _data.public.collections.length is 0 or force then _readPublicCollections() else _data.public.collections)

  _defineOwnCollections = (force) ->
    $q.when(if !_data.collections or _data.collections.length is 0 or force then _readOwnCollections() else _data.collections)

  _addProduct = (collection_id, product) ->
    deferred  = $q.defer()
    product.updating = deferred.promise
    eeBack.collectionAddProduct collection_id, product.id, eeAuth.fns.getToken()
    .then (storeProduct) ->
      product.storeProductId = storeProduct.id
      $rootScope.$broadcast 'added:product', product, collection_id
    .catch (err) -> if err and err.message then product.err = err.message; throw err
    .finally () -> product.updating = false

  _removeProduct = (collection_id, storeproduct) ->
    deferred  = $q.defer()
    storeproduct.updating = deferred.promise
    eeBack.collectionRemoveProduct collection_id, storeproduct.product_id, eeAuth.fns.getToken()
    .then () -> storeproduct.removed = true
    .catch (err) -> if err and err.message then storeproduct.err = err.message; throw err
    .finally () -> storeproduct.updating = false

  $rootScope.$on 'sync:collections', (e, collection) ->
    in_set = false
    sync = (coll) ->
      if coll.id is collection.id
        in_set = true
        coll.title        = collection.title
        coll.banner       = collection.banner
        coll.headline     = collection.headline
        coll.in_carousel  = collection.in_carousel
    sync coll for coll in _data.collections
    _data.collections.push collection unless in_set
    _setFirstTenCollections()

  $rootScope.$on 'remove:collections', (e, id) ->
    (if coll.id is id then coll = {}) for coll in _data.collections
    _setFirstTenCollections()

  ## EXPORTS
  data: _data
  fns:
    resetCollections:         _resetCollections
    createCollection:         _createCollection
    definePublicCollections:  _definePublicCollections
    defineOwnCollections:     _defineOwnCollections
    addProduct:               _addProduct
    removeProduct:            _removeProduct
