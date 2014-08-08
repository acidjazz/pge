
rate =

  zones: {}
  el: {}
  els: {}
  points: {}
  prices: {}


  i: (name) ->

    rate.els[name] = {}
    rate.points[name] = {}
    rate.zones[name] = []

    rate.el = $(name)

    rate.els[name].slide = $ rate.el.find '.slide'
    rate.els[name].slider = $ rate.el.find '.slider'
    rate.points[name].start = - (rate.els[name].slide.width()/2) - 15
    rate.points[name].end = rate.els[name].slider.width() - (rate.els[name].slide.width()/2) - 15

    rate.el.find('.zone').each( (i, el) ->
      rate.zones[name].push
        el: $(el)
        price: $(el).data 'price'
        rect: el.getBoundingClientRect()

      rate.prices[name] = $(el).data 'price' if i is 0
      $(el).addClass 'full' if i is 0
    )

    #$('.rates').on 'drag', "#{name} > .slider > .slide", {name: name}, rate.dragevent
    rate.handle name

  handle: (name) ->

   #rate.els[name].slide.unbind 'drag', rate.dragevent
   rate.els[name].slide.on 'drag', {name: name}, rate.dragevent

  #drag handler
  dragevent: (ev, dd) ->

    name = ev.data.name

    if dd.offsetX - ($(this).width() / 2) < 0 || dd.offsetX - ($(this).width() / 2) > rate.points[name].end
      return true

    $(this).css({left: dd.offsetX - ($(this).width() / 2) })

    rate.newprice rate.linedup($(this)[0].getBoundingClientRect(), name), name

  # return the price of the lined up zone
  linedup: (rect, name) ->

    #no .width in ie8
    middle = rect.left + ((rect.right-rect.left)/2)
    #middle = rect.left + (rect.width/2)
    #

    for zone, i in rate.zones[name]
      if middle > zone.rect.left and zone.rect.right > middle
        return {price: zone.price, el: zone.el}
  
  # update the price if we have a new one
  newprice: (zone, name) ->
    return true if !zone or !zone.price or rate.prices[name] is zone.price
    rate.els[name].slide.find('.price').html '$' + zone.price
    rate.prices[name] = zone.price
    $('.zone').removeClass 'full'
    zone.el.addClass 'full'

