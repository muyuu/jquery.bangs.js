# ----------------------------------
# Adjust Height jQuery plugin Bangs
# ----------------------------------
(($) ->
  $.fn.bangs = ->
    self = this
    lists = $(self)
    maxH = 0

    # height reset
    self.init = ()->
      maxH = 0
      lists.css
        "height": ""


    self.adjust = ()->
      lists.each ->
        h = $(this).height()
        maxH = h  if maxH < h

      lists.height maxH


    # onload event
    $(window).load ->
      self.init()
      self.adjust()


    # resize event
    timer = false
    $(window).resize ->
      self.init()
      self.adjust()

) jQuery