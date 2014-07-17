
pge =

  i: () ->

    pge.handlers()

  handlers: ->

    $('.rateframe > .buttons > .button').click pge.switchrate

  switchrate: ->

    t = $ this

    _.off $('.rate')
    t.parent().find('.button').removeClass 'active'
    t.addClass 'active'

    _.on t.data 'rate'
    rate.i t.data 'rate'

