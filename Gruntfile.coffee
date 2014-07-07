module.exports = (grunt) ->

  # Load bower grunt tasks
  grunt.loadNpmTasks('grunt-bower-task');

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # page open
    bower:
      install:
        options:
          targetDir: 'libs'
          layout: 'byComponent'
          install: true
          verbose: false
          cleanTargetDir: true
          cleanBowerDir: true

  # default
  grunt.registerTask "default", []

  # bower set
  grunt.registerTask "lib", ['bower']
