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

  notify: (message, status = 'warning') ->
    view = new Georgia.Views.Message(message: message, status: status)
    @$('.messages').prepend(view.render().el)

  activateTabs: ->
    @$('.form .nav.nav-tabs > li:first-child > a').trigger('click')

  new: (event) ->
    event.preventDefault()
    @collection.add([{}])
    this

  handleError: (instance, response) =>
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        @notify("#{if attribute == 'base' then '' else attribute} #{message}", 'error') for message in messages
    else
      @notify('Oups. Something went wrong.', 'error')