class Georgia.Views.Panel extends Backbone.View

  events:
    'click .new-form': 'new'
    'click .swap-panel': 'swapPanels'

  initialize: (options) ->
    @images = options.images
    @locales = $(@el).data('locales').split(',')
    @collection.on('reset', @render, this)
    @collection.on('add', @renderForm, this)

  swapPanels: (event) ->
    direction = 'left'
    speed = 'fast'
    event.preventDefault() if event
    @$('.panel.active').hide('slide', { direction: direction }, speed, =>
      @$(".panel:not('.active')").show('slide', { direction: direction }, speed, =>
        @$('.panel').toggleClass('active')
      )
    )

  activateTabs: ->
    @$('.form .nav.nav-tabs > li:first-child > a').trigger('click')