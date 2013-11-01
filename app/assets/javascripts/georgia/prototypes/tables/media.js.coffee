class @MediaTable

  constructor: (element) ->
    @element      = $(element)
    @checkboxes   = @element.find("input:checkbox")
    @downloadBtn  = $('.js-download')
    @deleteBtn    = $('.js-delete')
    @setBindings()

  setBindings: () =>
    @checkboxes.on('click', @update)
    @deleteBtn.on('click', @delete)

  update: () =>
    @updateDownloadableIds()
    if @getChecked().length
      @showActions()
    else
      @hideActions()

  delete: (event) =>
    @stopEvent(event)
    $.ajax(
      url: '/admin/media/delete'
      type: 'DELETE'
      data:
        ids: @getIds()
    )

  updateDownloadableIds: () =>
    $('.downloadable-ids').val(@getIds())

  showActions: () =>
    @downloadBtn.removeClass('hide')
    @deleteBtn.removeClass('hide')

  hideActions: () =>
    @downloadBtn.addClass('hide')
    @deleteBtn.addClass('hide')

  stopEvent: (event) ->
    event.stopPropagation()
    event.preventDefault()

  getChecked: () => @element.find("input:checkbox:checked[data-checkbox='child']")
  getId:      (c) => $(c).data('id')
  getIds:     () => $.map(@getChecked(), (c) => @getId(c))

$.fn.actsAsMediaTable = () ->
  @each ->
    new MediaTable($(this))

jQuery ->
  $("table.assets.js-checkboxable").each ->
    $(this).actsAsMediaTable()