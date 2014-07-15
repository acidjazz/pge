
rate =

  zones: {}
  els: {}
  points: {}
  prices: {}


  i: (name) ->

    console.log name

    rate.els[name] = {}
    rate.points[name] = {}
    rate.zones[name] = []

    el = $(name)

    rate.els[name].slide = $ el.find '.slide'
    rate.els[name].slider = $ el.find  '.slider'
    rate.points[name].start = - ( rate.els[name].slide.width()/2 )
    rate.points[name].end = rate.els[name].slider.width() - (rate.els[name].slide.width()/2)

    el.find('.zone').each( (i, el) ->
      rate.zones[name].push
        price: $(el).data 'price'
        rect: el.getBoundingClientRect()

      rate.prices[name] = $(el).data 'price' if i is 0
    )

    #$('.rates').on 'drag', "#{name} > .slider > .slide", {name: name}, rate.dragevent
    rate.handle name
  handle: (name) ->

   console.log "handling #{name}"

   rate.els[name].slide.unbind('drag', rate.dragevent)
   rate.els[name].slide.on 'drag', {name: name}, rate.dragevent

  #drag handler
  dragevent: (ev, dd) ->

    name = ev.data.name

    if dd.offsetX < rate.points[name].start || dd.offsetX > rate.points[name].end
      return true

    $(this).css({left: dd.offsetX})

    rate.newprice rate.linedup($(this)[0].getBoundingClientRect(), name), name

  # return the price of the lined up zone
  linedup: (rect, name) ->

    middle = rect.left + (rect.width/2)

    for zone, i in rate.zones[name]
      if middle > zone.rect.left and zone.rect.right > middle
        return zone.price
  
  # update the price if we have a new one
  newprice: (price, name) ->
    return true if rate.prices[name] is price or price is undefined
    rate.els[name].slide.find('.price').html '$' + price
    rate.prices[name] = price
    console.log price



