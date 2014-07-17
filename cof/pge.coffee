
pge =

  i: () ->

    pge.handlers()

  handlers: ->

    $('.rateframe > .buttons > .button').click pge.switchrate

  switchrate: ->

    t = $ this

    frame = t.parent().parent('.rateframe').attr('class').replace 'rateframe ', ''

    _.off ".#{frame} > .rates > .rate"
    t.parent().find('.button').removeClass 'active'
    t.addClass 'active'

    _.on t.data 'rate'
    rate.i t.data 'rate'

