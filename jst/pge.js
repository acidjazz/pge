var pge;

pge = {
  moving: false,
  start: 0,
  end: 0,
  i: function() {
    pge.end = $('.slider').width() - ($('.slide').width() / 2);
    pge.start = -$('.slide').width() / 2;
    return pge.handlers();
  },
  handlers: function() {
    return $('.slide').drag(pge.drag);
  },
  drag: function(ev, dd) {
    var t, x;
    t = $(this);
    x = dd.offsetX;
    if (x < pge.start || x > pge.end) {
      return true;
    }
    return t.css({
      left: x
    });
  }
};
