var rate;

rate = {
  zones: {},
  el: {},
  els: {},
  points: {},
  prices: {},
  i: function(name) {
    rate.els[name] = {};
    rate.points[name] = {};
    rate.zones[name] = [];
    rate.el = $(name);
    rate.els[name].slide = $(rate.el.find('.slide'));
    rate.els[name].slider = $(rate.el.find('.slider'));
    rate.points[name].start = -(rate.els[name].slide.width() / 2);
    rate.points[name].end = rate.els[name].slider.width() - (rate.els[name].slide.width() / 2);
    rate.el.find('.zone').each(function(i, el) {
      rate.zones[name].push({
        el: $(el),
        price: $(el).data('price'),
        rect: el.getBoundingClientRect()
      });
      if (i === 0) {
        rate.prices[name] = $(el).data('price');
      }
      if (i === 0) {
        return $(el).addClass('full');
      }
    });
    return rate.handle(name);
  },
  handle: function(name) {
    rate.els[name].slide.unbind('drag', rate.dragevent);
    return rate.els[name].slide.on('drag', {
      name: name
    }, rate.dragevent);
  },
  dragevent: function(ev, dd) {
    var name;
    name = ev.data.name;
    if (dd.offsetX < rate.points[name].start || dd.offsetX > rate.points[name].end) {
      return true;
    }
    $(this).css({
      left: dd.offsetX
    });
    return rate.newprice(rate.linedup($(this)[0].getBoundingClientRect(), name), name);
  },
  linedup: function(rect, name) {
    var i, middle, zone, _i, _len, _ref;
    middle = rect.left + (rect.width / 2);
    _ref = rate.zones[name];
    for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
      zone = _ref[i];
      if (middle > zone.rect.left && zone.rect.right > middle) {
        return {
          price: zone.price,
          el: zone.el
        };
      }
    }
  },
  newprice: function(zone, name) {
    if (rate.prices[name] === zone.price || zone.price === void 0) {
      return true;
    }
    rate.els[name].slide.find('.price').html('$' + zone.price);
    rate.prices[name] = zone.price;
    $('.zone').removeClass('full');
    return zone.el.addClass('full');
  }
};
