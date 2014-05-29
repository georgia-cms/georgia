class @MediaTable

  constructor: (element, checkboxable) ->
    @element      = $(element)
    @checkboxable = checkboxable
    @downloadBtn  = $('.js-download')
    @deleteBtn    = $('.js-delete')
    @setBindings()

  checkboxes: () -> @element.find("input:checkbox")

  setBindings: () =>
    @element.on('click', @checkboxes(), @update)
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
      @checkboxable.uncheck(@checkboxable.selectAllCheckbox)
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

  getChecked: () => @element.find("input:checkbox:checked")
  getId:      (c) => $(c).data('id')
  getIds:     () => $.map(@getChecked(), (c) => @getId(c))

$.fn.actsAsMediaTable = () ->
  @each ->
    checkboxable = new Checkboxable($(this))
    new MediaTable($(this), checkboxable)

jQuery ->
  $("table.assets.js-checkboxable").each ->
    $(this).actsAsMediaTable()