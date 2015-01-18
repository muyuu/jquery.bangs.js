# ----------------------------------
# Adjust Height jQuery plugin Bangs
# ----------------------------------
((w, $) ->
  $.fn.bangs = (options)->
    elements = $(@)
    maxH = 0

    # option
    defaults =
      item: ".bangs__item"

    opts = $.extend({}, defaults, options)

    # セレクタで指定した要素の個数分数値を変える必要があるから
    # その要素分繰り返す
    elements.each (index)->
      element = $(@)
      items = element.find(opts.item)

      # height reset
      init = ()->
        maxH = 0
        items.css
          "height": ""

      # adjust height
      adjust = ()->
        items.each ->
          h = $(@).height()
          maxH = h  if maxH < h

        items.height maxH

      # onload event
      $(window).on "load resize", ->
        init()
        adjust()
      return
    return
) window, jQuery