pge =

  moving: false
  start: 0
  end: 0

  i: ->

    pge.end = $('.slider').width() - ($('.slide').width()/2)
    pge.start = -$('.slide').width()/2
    pge.handlers()

  handlers: ->
    $('.slide').drag pge.drag

  drag: (ev, dd) ->

    t = $ this
    x = dd.offsetX

    if x < pge.start || x > pge.end
      return true
    t.css(
      left: x
    )
