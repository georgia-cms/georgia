class @MediaTable

  constructor: (element) ->
    @element      = $(element)
    @downloadBtn  = $('.js-download')
    @deleteBtn    = $('.js-delete')
    @setBindings()

  setBindings: () =>
    @element.on('click', @element.find("input:checkbox"), @update)
    @deleteBtn.on('click', @destroy)

  update: () =>
    @updateDownloadableIds()
    if @getChecked().length
      @enableActions()
    else
      @disableActions()

  # TODO: Should mark item while request is sent. Should sent one request per selected asset for faster feedback
  destroy: (event) =>
    @stopEvent(event)
    $.ajax(
      type: 'DELETE'
      url: '/admin/media'
      data:
        id: @getIds()
      dataType: 'JSON'
    ).always(() =>
      $.each @getIds(), (index, id) -> $("#asset_#{id}").remove()
    )

  updateDownloadableIds: () =>
    $('.downloadable-ids').val(@getIds())

  enableActions: () =>
    @downloadBtn.removeClass('disabled').addClass('btn-info')
    @deleteBtn.removeClass('disabled').addClass('btn-danger')

  disableActions: () =>
    @downloadBtn.addClass('disabled').removeClass('btn-info')
    @deleteBtn.addClass('disabled').removeClass('btn-danger')

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