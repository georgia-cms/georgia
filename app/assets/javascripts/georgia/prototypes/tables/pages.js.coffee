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
      @showActions()
    else
      @hideActions()

  delete: (event) =>
    @stopEvent(event)
    $.ajax(
      url: "/admin/pages/#{@getIds()}"
      type: 'DELETE'
    )

  showActions: () =>
    @deleteBtn.removeClass('hide')

  hideActions: () =>
    @deleteBtn.addClass('hide')

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