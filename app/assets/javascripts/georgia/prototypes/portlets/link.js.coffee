class @LinkPortlet

  constructor: (element) ->
    @element = $(element)
    @expandBtn = @element.find('.js-expand')

    @setBindings()

  setBindings: () =>
    @expandBtn.on('click', @toggleExpand)
    @element.on('click', '.js-remove-slide', @removeSlide)

  toggleExpand: () =>
    @element.find('> ol').toggleClass('hide')
    @expandBtn.find('i').toggleClass('hide')
    @element.toggleClass('is-expanded')

  removeSlide: (event) =>
    event.preventDefault()
    portlet = $(event.currentTarget).closest('.portlet')
    portlet.find('input.js-destroy').val('1')
    portlet.hide()
