gulp = require "gulp"
jade = require "gulp-jade"
sass = require "gulp-ruby-sass"
coffee = require "gulp-coffee"
connect = require "gulp-connect"
open = require "gulp-open"
concat = require "gulp-concat"
changed = require 'gulp-changed'
plumber = require 'gulp-plumber'
karma = require 'gulp-karma'



src =
  dir: "./src/"
  jade: "./src/jade/"
  sass: "./src/sass/"
  coffee: "./src/coffee/"

dist =
  dir: "./"
  asset: ""
  css: "./css/"
  js: "./"
  lib: "./libs/"
  img: "./img/"

txt =
  dir: "./txt/"

spec =
  dir: "./spec/"
  coffee: "./spec/coffee/"
  fixture: "./spec/fixtures/"


jsFiles = [
  "#{dist.js}jquery.bangs.js"
]


karmaFiles = [
  "#{dist.lib}jquery/jquery.min.js"
  "#{dist.lib}jasmine-jquery/jasmine-jquery.js"
  "#{dist.js}jquery.bangs.js"
  "#{spec.dir}**/*Spec.js"
  "#{spec.fixture}**/*.html"
]


# local server
gulp.task "connect", ->
  connect.server
    root: "#{dist.dir}"
    port: 3000
    livereload: true



# open
gulp.task "url", ->
  options =
    url: "http://localhost:3000"
    app: "Google Chrome"

  gulp.src "#{dist.dir}index.html"
    .pipe open "", options



# jade
gulp.task "jade", ->
  gulp.src ["#{src.jade}**/*.jade", "!#{src.jade}**/_*.jade"]
    .pipe changed "#{dist.dir}", { hasChanged: changed.compareSha1Digest }
    .pipe plumber()
    .pipe jade
      pretty: true
      basedir: "#{src.jade}"
    .pipe gulp.dest "#{dist.dir}"
    .pipe connect.reload()



# sass
gulp.task "sass", ->
  gulp.src "#{src.sass}style.sass"
    .pipe plumber()
    .pipe sass
      sourcemap: true
    .pipe gulp.dest("#{dist.css}")
    .pipe connect.reload()



# coffee
gulp.task "coffee", ->
  gulp.src "#{src.coffee}**/*.coffee"
    .pipe plumber()
    .pipe coffee
      bare: true
    .pipe gulp.dest("#{dist.js}")
    .pipe connect.reload()


# specCoffee
gulp.task "specCoffee", ->
  gulp.src "#{spec.coffee}**/*.coffee"
    .pipe plumber()
    .pipe coffee
      bare: true
    .pipe gulp.dest("#{spec.dir}")




# karma
gulp.task 'karma', ->
  gulp.src files
    .pipe karma
      configFile: 'karma.conf.js'
      action: 'run'



# watch
gulp.task "watch", ->
  gulp.watch "#{src.jade}**/*.jade", ["jade"]
  gulp.watch "#{src.sass}**/*.sass", ["sass"]
  gulp.watch "#{src.coffee}**/*.coffee", ["coffee"]
  gulp.watch "#{spec.coffee}**/*.coffee", ["specCoffee"]
  gulp.src karmaFiles
    .pipe karma
      configFile: 'karma.conf.js'
      action: 'watch'




gulp.task "default", ->
  # gulp.start "connect", "url", "watch"
  gulp.start "connect", "watch"

