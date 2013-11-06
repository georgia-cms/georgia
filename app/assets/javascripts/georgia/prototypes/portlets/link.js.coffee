class @LinkPortlet

  constructor: (element) ->
    @element = $(element)
    @expandBtn = @element.find('.js-expand')
    @removeBtn = @element.find('.js-remove-link')

    @setBindings()

  setBindings: () =>
    @expandBtn.on('click', @toggleExpand)
    @removeBtn.on('click', @removeLink)

  toggleExpand: () =>
    @element.find('> ol').toggleClass('hide')
    @expandBtn.find('i').toggleClass('hide')
    @element.toggleClass('is-expanded')

  removeLink: (event) =>
    event.preventDefault()
    portlet = $(event.currentTarget).closest('.portlet')
    portlet.find('input.js-destroy').val('1')
    portlet.hide()
