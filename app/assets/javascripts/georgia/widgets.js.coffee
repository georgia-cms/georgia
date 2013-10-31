class @Widget

  constructor: (element) ->
    @element = $(element)
    @widget = @element.find('.widget-show')
    @widgetForm = @element.find('.widget-form')
    @editLink = @element.find('.js-edit')
    @cancelLink = @element.find('.js-close')
    @setBindings()

  setBindings: () =>
    @editLink.bind('click', @showForm)
    @cancelLink.bind('click', @hideForm)

  showForm: () =>
    @widget.addClass('hide')
    @widgetForm.removeClass('hide')

  hideForm: () =>
    @widgetForm.addClass('hide')
    @widget.removeClass('hide')


$.fn.widget = () ->
  @each ->
    new Widget($(this))

jQuery ->
  $(".js-widget").each () ->
    $(this).widget()