process.env.NODE_ENV = 'test'
utils           = require './utils.e2e.db'
chai            = require 'chai'
expect          = require('chai').expect
should          = chai.should()
chaiAsPromised  = require 'chai-as-promised'
chai.use chaiAsPromised
_               = require 'lodash'

elem    = {}
scope   = {}

describe 'eeosk new.try.edit', () ->

  before () -> utils.reset browser

  it 'should have proper messaging', () ->
    browser.get '/try/edit'
    browser.getTitle().should.eventually.contain 'Try it out'
    element(has.css('#ee-middle-view')).getText()
    .then (text) ->
      text.should.contain 'Great!'
      text.should.contain 'Now try editing your store below'
      text.should.contain 'Top bar colors'
      text.should.contain 'Main image'
      text.should.contain 'Store title'
      text.should.contain 'There are many more options once you\'ve saved your store.'
      text.should.contain 'Add Products'
      text.should.contain 'Save'

  it 'should have default theme on reload', () ->
    theme =
      topBarColor: 'rgb(2, 23, 9)'
      topBarBackgroundColor: 'rgb(219, 214, 255)'
      mainImageSrc: 'v1425250403/desk1.jpg'
    element(has.css '[name="store-navbar"] ul:first-child > li:first-child a').getAttribute('style').should.eventually.contain theme.topBarColor
    element(has.css 'ee-storefront-header .navbar-rgba-colors').getAttribute('style').should.eventually.contain theme.topBarBackgroundColor
    element(has.css '.carousel > img').getAttribute('src').should.eventually.contain theme.mainImageSrc

  it 'should navigate to "Add Products" with the button below', () ->
    element(has.cssContainingText '#ee-middle-view .btn', 'Add Products').click()
    browser.getTitle().should.eventually.contain 'Add products'
    browser.getCurrentUrl().should.eventually.equal 'http://localhost:3333/try/products'
    browser.navigate().back()

  it 'should navigate to "Add Products" via navbar', () ->
    element(has.cssContainingText '#ee-header .btn', 'Add Products').click()
    browser.getTitle().should.eventually.contain 'Add products'
    browser.getCurrentUrl().should.eventually.equal 'http://localhost:3333/try/products'
    browser.navigate().back()

  it 'should navigate to "Preview" via navbar', () ->
    element(has.cssContainingText '#ee-header .btn', 'Preview').click()
    browser.getTitle().should.eventually.contain 'My store'
    browser.getCurrentUrl().should.eventually.equal 'http://localhost:3333/try/storefront'
    browser.navigate().back()

  it 'should close popover on click', () ->
    element(has.css '#ee-middle-view .popover').isDisplayed().should.eventually.equal true
    element(has.cssContainingText '#ee-middle-view .popover .btn', 'close').click()
    element(has.css '#ee-middle-view .popover').isDisplayed().should.eventually.equal false

  it 'should adjust top bar background color', () ->
    element(has.css 'input[name="topBarBackgroundColor"]').getAttribute('value').should.eventually.equal '#dbd6ff'
    element(has.css 'input[name="topBarBackgroundColor"]').click()
    element(has.css '.colorpicker-visible colorpicker-saturation').click()
    element(has.css 'input[name="topBarBackgroundColor"]').getAttribute('value').should.eventually.equal '#494180'
    element(has.css 'ee-storefront-header .navbar-rgba-colors').getAttribute('style').should.eventually.contain utils.hex_to_rgb('#494180')

  it 'should adjust top bar color', () ->
    element(has.css 'input[name="topBarColor"]').getAttribute('value').should.eventually.equal '#021709'
    element(has.css 'input[name="topBarColor"]').click()
    element(has.css '.colorpicker-visible colorpicker-saturation').click()
    element(has.css 'input[name="topBarColor"]').getAttribute('value').should.eventually.equal '#418056'
    element(has.css '[name="store-navbar"] ul:first-child > li:first-child a').getAttribute('style').should.eventually.contain utils.hex_to_rgb('#418056')

  it 'should adjust carousel image', () ->
    element(has.css '.btn[name="mainImageToggle"]').click()
    newTheme = element(has.repeater('theme in edit.data.demoStores').row(3))
    newTheme.getAttribute('src')
    .then (src) ->
      newMainImgUrl = src.split('w_1200')[1]
      newTheme.click()
      element(has.css '.carousel > img').getAttribute('src').should.eventually.contain newMainImgUrl

  it 'should adjust store title', () ->
    title = 'Test Store Title'
    element(has.model 'edit.ee.meta.home.name').sendKeys title
    element(has.css '[name="store-navbar"] .navbar-brand').getText().should.eventually.contain title

  xit 'should not allow click on navbar', () ->

  xit 'should persist information on signup', () ->
  xit 'should', () ->
  xit 'should', () ->
  xit 'should', () ->
  xit 'should', () ->
