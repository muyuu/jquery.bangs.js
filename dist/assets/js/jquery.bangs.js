(function(w, $) {
  return $.fn.bangs = function(options) {
    var defaults, elements, maxH, opts;
    elements = $(this);
    maxH = 0;
    defaults = {
      item: ".bangs__item"
    };
    opts = $.extend({}, defaults, options);
    elements.each(function(index) {
      var adjust, element, init, items;
      element = $(this);
      items = element.find(opts.item);
      init = function() {
        maxH = 0;
        return items.css({
          "height": ""
        });
      };
      adjust = function() {
        items.each(function() {
          var h;
          h = $(this).height();
          if (maxH < h) {
            return maxH = h;
          }
        });
        return items.height(maxH);
      };
      $(window).on("load resize", function() {
        init();
        return adjust();
      });
    });
  };
})(window, jQuery);
