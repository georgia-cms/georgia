# FIXME: Use PositionSort
class @SlidePortlet

  constructor: (element) ->
    @element = $(element)
    @slideList = @element.find('.js-sortable')
    @addSlideBtn = $('.js-add-slide')

    @setBindings()

  setBindings: () =>
    @addSlideBtn.on('click', @addSlide)
    @element.on('click', '.js-remove-slide', @removeSlide)
    @slideList.sortable(axis: 'y')
    @slideList.on( "sortupdate", @updatePosition)

  addSlide: (event) =>
    event.preventDefault()
    $.ajax(
      url: "/admin/slides/new"
    ).done( (data) => @slideList.append(data) )

  removeSlide: (event) =>
    event.preventDefault()
    portlet = $(event.currentTarget).closest('.portlet')
    portlet.find('input.js-destroy').val('1')
    portlet.hide()

  updatePosition: (event, ui) =>
    @slideList.find('.js-position').each((index, el) -> $(el).val(index+1))

$.fn.slidePortlet = () ->
  @each ->
    new SlidePortlet($(this))

jQuery ->
  $(".js-slides").each () ->
    $(this).slidePortlet()