var rate;

rate = {
  zones: {},
  els: {},
  points: {},
  prices: {},
  i: function(name) {
    var el;
    console.log(name);
    rate.els[name] = {};
    rate.points[name] = {};
    rate.zones[name] = [];
    el = $(name);
    rate.els[name].slide = $(el.find('.slide'));
    rate.els[name].slider = $(el.find('.slider'));
    rate.points[name].start = -(rate.els[name].slide.width() / 2);
    rate.points[name].end = rate.els[name].slider.width() - (rate.els[name].slide.width() / 2);
    el.find('.zone').each(function(i, el) {
      rate.zones[name].push({
        price: $(el).data('price'),
        rect: el.getBoundingClientRect()
      });
      if (i === 0) {
        return rate.prices[name] = $(el).data('price');
      }
    });
    return rate.handle(name);
  },
  handle: function(name) {
    console.log("handling " + name);
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
        return zone.price;
      }
    }
  },
  newprice: function(price, name) {
    if (rate.prices[name] === price || price === void 0) {
      return true;
    }
    rate.els[name].slide.find('.price').html('$' + price);
    rate.prices[name] = price;
    return console.log(price);
  }
};
