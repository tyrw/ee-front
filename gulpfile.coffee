spawn = require('child_process').spawn

argv  = require('yargs').argv
gulp  = require 'gulp'
del   = require 'del'
gp    = do require "gulp-load-plugins"

streamqueue = require 'streamqueue'
combine     = require 'stream-combiner'
runSequence = require 'run-sequence'
protractor  = require('gulp-protractor').protractor

sources     = require './gulp.sources'

# ==========================
# task options

distPath = './dist'
scope = {}

htmlminOptions =
  removeComments: true
  removeCommentsFromCDATA: true
  collapseWhitespace: true
  collapseBooleanAttributes: true
  removeAttributeQuotes: true
  removeRedundantAttributes: true
  caseSensitive: true
  minifyJS: true
  minifyCSS: true

## ==========================
## del tasks
gulp.task 'del-dist', () -> del distPath
gulp.task 'del-js', () -> del './src/js'

## ==========================
## html tasks

copyDevHtml = () ->
  console.log 'updated ./src/builder.html'
  gulp.src './src/builder.html'
    .pipe gp.plumber()
    .pipe gp.htmlReplace
      css: 'ee-shared/stylesheets/ee.css'
      js: sources.builderJs(), { keepBlockTags: true }
    .pipe gulp.dest './src'

gulp.task 'html-dev', () -> copyDevHtml()

gulp.task 'html-prod', () ->
  gulp.src './src/builder.html'
    .pipe gp.plumber()
    # Replace localhost tracking code with product tracking code
    .pipe gp.replace /UA-55625421-2/g, 'UA-55625421-1'
    .pipe gp.htmlReplace
      css: 'ee-shared/stylesheets/ee.css'
      js: 'ee.builder.js'
    .pipe gp.htmlmin htmlminOptions
    .pipe gulp.dest distPath

  gulp.src ['./src/sitemap.xml', './src/robots.txt']
    .pipe gulp.dest distPath

# ==========================
# css tasks handled with copy-prod


# ==========================
# js tasks

copyToSrcJs = () ->
  gulp.src ['./src/**/!(constants.coffee)*.coffee'] # ** glob forces dest to same subdir
    .pipe gp.plumber()
    .pipe gp.sourcemaps.init()
    .pipe gp.coffee()
    .pipe gp.sourcemaps.write './'
    .pipe gulp.dest './src/js'

copyConstantToSrcJs = (url) ->
  gulp.src ['./src/**/constants.coffee'] # ** glob forces dest to same subdir
    .pipe gp.replace /@@eeBackUrl/g, url
    .pipe gp.plumber()
    .pipe gp.sourcemaps.init()
    .pipe gp.coffee()
    .pipe gp.sourcemaps.write './'
    .pipe gulp.dest './src/js'

copySingleToSrcJs = (path, url) ->
  split = path.split('/')
  file = split[split.length - 1]
  console.log 'copied ./src/**/' + file + ' to ./src/js/**/' + file
  gulp.src './src/**/' + file
    .pipe gp.plumber()
    .pipe gp.sourcemaps.init()
    .pipe gp.coffee()
    .pipe gp.sourcemaps.write './'
    .pipe gulp.dest './src/js'

gulp.task 'js-constant-5555', () -> copyConstantToSrcJs 'http://localhost:5555'
gulp.task 'js-constant-5000', () -> copyConstantToSrcJs 'http://localhost:5000'

gulp.task 'js-dev', () -> copyToSrcJs()
gulp.task 'js-test',  () -> runSequence 'js-dev', 'js-constant-5555'
# gulp.task 'js-dev',  () -> runSequence 'js-dev', 'copyConstant5000'
# gulp.task 'js-dev', () ->
#   copyToSrcJs()
#   copyConstantToSrcJs 'http://localhost:5000'

gulp.task 'js-prod', () ->
  # inline templates; no need for ngAnnotate
  appTemplates = gulp.src './src/ee-shared/components/ee*.html'
    .pipe gp.htmlmin htmlminOptions
    .pipe gp.angularTemplatecache
      module: 'ee.templates'
      standalone: true
      root: 'ee-shared/components'

  ## Builder prod
  builderVendorMin    = gulp.src sources.builderVendorMin
  builderVendorUnmin  = gulp.src sources.builderVendorUnmin
  # builder modules; replace and annotate
  builderModules = gulp.src sources.builderModules()
    .pipe gp.plumber()
    .pipe gp.replace "# 'ee.templates'", "'ee.templates'" # for builder.index.coffee $templateCache
    .pipe gp.replace "'env', 'development'", "'env', 'production'" # TODO use gulp-ng-constant
    .pipe gp.replace /@@eeBackUrl/g, 'https://api.eeosk.com'
    .pipe gp.coffee()
    .pipe gp.ngAnnotate()
  # minified and uglify vendorUnmin, templates, and modules
  builderCustomMin = streamqueue objectMode: true, builderVendorUnmin, appTemplates, builderModules
    .pipe gp.uglify()
  # concat: vendorMin before jsMin because vendorMin has angular
  streamqueue objectMode: true, builderVendorMin, builderCustomMin
    .pipe gp.concat 'ee.builder.js'
    .pipe gulp.dest distPath

gulp.task 'js-stage', () ->
  gulp.src distPath + '/ee.builder.js'
    .pipe gp.plumber()
    .pipe gp.replace /api\.eeosk\.com/g, 'ee-back-staging.herokuapp.com'
    .pipe gulp.dest distPath


# ==========================
# other tasks
# copy non-compiled files

gulp.task 'copy-prod', () ->

  gulp.src './src/ee-shared/**/*.html'
    .pipe gp.plumber()
    .pipe gp.changed distPath
    .pipe gulp.dest distPath + '/ee-shared'

  gulp.src './src/builder/**/*.html'
    .pipe gp.plumber()
    .pipe gp.changed distPath
    .pipe gulp.dest distPath + '/builder'

  gulp.src './src/components/**/*.html'
    .pipe gp.plumber()
    .pipe gp.changed distPath
    .pipe gulp.dest distPath + '/components'

  gulp.src './src/ee-shared/fonts/*.*'
    .pipe gp.plumber()
    .pipe gp.changed distPath
    .pipe gulp.dest distPath + '/ee-shared/fonts'

  gulp.src './src/ee-shared/img/*.*'
    .pipe gp.plumber()
    .pipe gp.changed distPath
    .pipe gulp.dest distPath + '/ee-shared/img'

  gulp.src './src/ee-shared/stylesheets/*.*'
    .pipe gp.plumber()
    .pipe gp.changed distPath
    .pipe gulp.dest distPath + '/ee-shared/stylesheets'

# ==========================
# protractors

gulp.task 'protractor-test', () ->
  gulp.src ['./src/e2e/config.coffee', './src/e2e/*.coffee']
    .pipe protractor
      configFile: './protractor.conf.js'
      args: ['--grep', (argv.grep || ''), '--baseUrl', 'http://localhost:3333', '--apiUrl', 'http://localhost:5555']
    .on 'error', (e) -> return

gulp.task 'protractor-prod', () ->
  gulp.src ['./src/e2e/config.coffee', './src/e2e/*.coffee']
    .pipe protractor
      configFile: './protractor.conf.js'
      args: ['--baseUrl', 'http://localhost:3333', '--apiUrl', 'http://localhost:5555']
    .on 'error', (e) -> return

gulp.task 'protractor-live', () ->
  gulp.src ['./src/e2e/config.coffee', './src/e2e/*.coffee']
    .pipe protractor
      configFile: './protractor.conf.js'
      args: ['--grep', (argv.grep || ''), '--baseUrl', 'https://eeosk.com', '--apiUrl', 'https://api.eeosk.com']
    .on 'error', (e) -> return

# ==========================
# servers

gulp.task 'server-test', () ->
  gulp.src('./src').pipe gp.webserver(
    fallback: 'builder.html' # for angular html5mode
    port: 3333
  )

gulp.task 'server-dev', () ->
  gulp.src('./src').pipe gp.webserver(
    fallback: 'builder.html' # for angular html5mode
    port: 3000
  )

gulp.task 'server-prod', () -> spawn 'foreman', ['start'], stdio: 'inherit'

# ==========================
# watchers

gulp.task 'watch-dev', () ->
  gulp.watch './src/**/*.coffee', (obj) -> copySingleToSrcJs obj.path, 'http://localhost:5000'
  gulp.watch './src/**/constants.coffee', (obj) -> copyConstantToSrcJs 'http://localhost:5000'
  gulp.watch './src/builder.html', (obj) -> copyDevHtml()

gulp.task 'watch-test', () ->
  gulp.src './src/**/*.coffee'
    .pipe gp.watch { emit: 'one', name: 'js' }, ['js-test']
  gulp.src './src/e2e/*e2e*.coffee'
    .pipe gp.watch { emit: 'one', name: 'test' }, ['protractor-test']

# ===========================
# runners

gulp.task 'test', ['js-test', 'html-dev', 'server-test', 'watch-test'], () -> return
gulp.task 'dev', (cb) -> runSequence 'del-js', 'js-dev', 'js-constant-5000', 'html-dev', 'server-dev', 'watch-dev', cb
gulp.task 'prod', (cb) -> runSequence 'del-dist', 'del-js', 'js-dev', 'js-prod', 'html-dev', 'html-prod', 'copy-prod', 'server-prod', cb
gulp.task 'stage', (cb) -> runSequence 'del-dist', 'del-js', 'js-dev', 'js-prod', 'html-dev', 'html-prod', 'copy-prod', 'js-stage', cb
