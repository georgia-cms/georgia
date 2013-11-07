class @PagesTable

  constructor: (element) ->
    @element      = $(element)
    @checkboxes   = @element.find("input:checkbox")
    @deleteBtn    = $('.js-delete')
    @setBindings()

  setBindings: () =>
    @checkboxes.on('click', @update)
    @deleteBtn.on('click', @delete)

  update: () =>
    if @getChecked().length
      @enableActions()
    else
      @disableActions()

  delete: (event) =>
    @stopEvent(event)
    $.ajax(
      url: "/admin/pages/#{@getIds()}"
      type: 'DELETE'
    )

  enableActions: () =>
    @deleteBtn.removeClass('disabled')

  disableActions: () =>
    @deleteBtn.addClass('disabled')

  stopEvent: (event) ->
    event.stopPropagation()
    event.preventDefault()

  getChecked: () => @element.find("input:checkbox:checked[data-checkbox='child']")
  getId:      (c) => $(c).data('id')
  getIds:     () => $.map(@getChecked(), (c) => @getId(c))

$.fn.actsAsPagesTable = () ->
  @each ->
    new PagesTable($(this))

jQuery ->
  $("table.pages.js-checkboxable").each ->
    $(this).actsAsPagesTable()