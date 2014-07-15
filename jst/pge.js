var pge;

pge = {
  i: function() {
    return pge.handlers();
  },
  handlers: function() {
    return $('.rateframe > .buttons > .button').click(pge.switchrate);
  },
  switchrate: function() {
    var t;
    t = $(this);
    _.off($('.rate'));
    t.parent().find('.button').removeClass('active');
    t.addClass('active');
    _.on(t.data('rate'));
    return rate.i(t.data('rate'));
  }
};
