gulp = require "gulp"
$ = require('gulp-load-plugins')()
gulpFilter = require 'gulp-filter'
mainBowerFiles = require 'main-bower-files'
del = require 'del'

src = "src/"
dist = "dist/"
asset = "assets/"
spec = "spec/"
txt = "txt/"

d =
  jade: src + "jade/"
  sass: src + "sass/"
  coffee: src + "coffee/"
  html: dist
  css: dist + asset + "./css/"
  js: dist + asset + "./js/"
  lib: dist + asset + "./libs/"
  img: dist + asset + "./img/"
  spec:
    coffee: spec + "coffee/"
    fixture: spec + "fixtures/"


jsFiles = [
  "#{d.js}jquery.bangs.js"
]


karmaFiles = [
  "#{d.lib}js/jquery.min.js"
  "#{d.lib}js/jasmine-jquery.js"
  "#{d.js}jquery.bangs.js"
  "#{spec}**/*Spec.js"
  "#{d.spec.fixture}**/*.html"
]


# bower
gulp.task 'clear-libs', ->
  del.sync "#{d.lib}"

gulp.task "bower", ['clear-libs'], ->
  jsFilter = gulpFilter ["**/*.js", "**/*.map"]
  cssFilter = gulpFilter "**/*.css"
  fontsFilter = gulpFilter ["**/*.otf", "**/*.eot","**/*.svg","**/*.ttf","**/*.woff"]

  gulp.src(mainBowerFiles())
    .pipe(jsFilter)
    .pipe(gulp.dest("#{d.lib}js"))
    .pipe(jsFilter.restore())
    .pipe(cssFilter)
    .pipe(gulp.dest("#{d.lib}css"))
    .pipe(cssFilter.restore())
    .pipe(fontsFilter)
    .pipe(gulp.dest("#{d.lib}fonts"))


# local server
gulp.task "connect", ->
  $.connect.server
    root: "#{d.html}"
    port: 3000
    livereload: true



# open
gulp.task "url", ->
  options =
    url: "http://localhost:3000"
    app: "Google Chrome"

  gulp.src "#{d.html}index.html"
    .pipe $.open "", options



# jade
gulp.task "jade", ->
  gulp.src ["#{d.jade}**/*.jade", "!#{d.jade}**/_*.jade"]
    .pipe $.changed "#{d.html}", { hasChanged: $.changed.compareSha1Digest }
    .pipe $.plumber()
    .pipe $.jade
      pretty: true
      basedir: "#{d.jade}"
    .pipe gulp.dest "#{d.html}"
    .pipe $.connect.reload()



# sass
gulp.task "sass", ->
  gulp.src "#{d.sass}style.sass"
    .pipe $.plumber()
    .pipe $['rubySass']
      sourcemap: true
    .pipe gulp.dest("#{d.css}")
    .pipe $.connect.reload()



# coffee
gulp.task "coffee", ->
  gulp.src "#{d.coffee}**/*.coffee"
    .pipe $.plumber()
    .pipe $.coffee
      bare: true
    .pipe gulp.dest("#{d.js}")
    .pipe gulp.dest("./")
    .pipe $.connect.reload()


# specCoffee
gulp.task "specCoffee", ->
  gulp.src "#{d.spec.coffee}**/*.coffee"
    .pipe $.plumber()
    .pipe $.coffee
      bare: true
    .pipe gulp.dest("#{spec}")




# karma
gulp.task 'karma', ->
  gulp.src files
    .pipe $.karma
      configFile: 'karma.conf.js'
      action: 'run'



# watch
gulp.task "watch", ->
  gulp.watch "#{d.jade}**/*.jade", ["jade"]
  gulp.watch "#{d.sass}**/*.sass", ["sass"]
  gulp.watch "#{d.coffee}**/*.coffee", ["coffee"]
  gulp.watch "#{d.spec.coffee}**/*.coffee", ["specCoffee"]
  gulp.src karmaFiles
    .pipe $.karma
      configFile: 'karma.conf.js'
      action: 'watch'




# 最初に使うタスク
gulp.task "lib", ->
  gulp.start "bower"


gulp.task "default", ->
  # gulp.start "connect", "url", "watch"
  gulp.start "connect", "watch"

