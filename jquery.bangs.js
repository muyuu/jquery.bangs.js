(function($) {
  return $.fn.bangs = function() {
    var lists, maxH, self, timer;
    self = this;
    lists = $(self);
    maxH = 0;
    self.init = function() {
      maxH = 0;
      return lists.css({
        "height": ""
      });
    };
    self.adjust = function() {
      lists.each(function() {
        var h;
        h = $(this).height();
        if (maxH < h) {
          return maxH = h;
        }
      });
      return lists.height(maxH);
    };
    $(window).load(function() {
      self.init();
      return self.adjust();
    });
    timer = false;
    return $(window).resize(function() {
      self.init();
      return self.adjust();
    });
  };
})(jQuery);
