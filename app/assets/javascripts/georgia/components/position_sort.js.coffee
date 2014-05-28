class @PositionSort

  constructor: (element) ->
    @element = $(element)
    @setBindings()

  setBindings: () =>
    @element.sortable(axis: 'y')
    @element.on( "sortupdate", @updatePosition)

  updatePosition: (event, ui) =>
    @element.find('.js-position').each((index, el) -> $(el).val(index+1))

$.fn.positionSort = () ->
  @each ->
    new PositionSort($(this))

jQuery ->
  $(".js-position-sort").each () ->
    $(this).positionSort()