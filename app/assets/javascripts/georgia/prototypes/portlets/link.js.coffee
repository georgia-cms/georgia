class @LinkPortlet

  constructor: (element) ->
    @element = $(element)
    @expandBtn = @element.find('> div > .js-expand')

    @setBindings()

  setBindings: () =>
    @expandBtn.on('click', @toggleExpand)

  toggleExpand: () =>
    @element.find('> ol').toggleClass('hide')
    @expandBtn.find('i').toggleClass('hide')
    @element.toggleClass('is-expanded')

$.fn.linkPortlet = () ->
  @each ->
    new LinkPortlet($(this))

jQuery ->
  $(".link").each () ->
    $(this).linkPortlet()