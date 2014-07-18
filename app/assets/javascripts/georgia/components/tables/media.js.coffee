class @MediaTable extends @Table

  constructor: (element, checkboxable) ->
    super(element, checkboxable)
    @downloadBtn  = $('.js-download')
    @deleteBtn    = $('.js-delete')
    @deleteBtn.on('click', @destroy)

  # TODO: Should mark item while request is sent. Should sent one request per selected asset for faster feedback
  destroy: (event) =>
    @stopEvent(event)
    $.ajax(
      url: "/admin/media/#{@getIds()}"
      type: 'DELETE'
      dataType: 'JSON'
      success: @removeAssets
    ).always(@notify)

  update: () =>
    @updateDownloadableIds()
    if @getChecked().length
      @enableActions()
    else
      @disableActions()

  removeAssets: () =>
    $.each @getIds(), (index, id) -> $("#asset_#{id}").remove()

  updateDownloadableIds: () =>
    $('.downloadable-ids').val(@getIds())

  enableActions: () =>
    @downloadBtn.removeClass('disabled').addClass('btn-info')
    @deleteBtn.removeClass('disabled').addClass('btn-danger')

  disableActions: () =>
    @downloadBtn.addClass('disabled').removeClass('btn-info')
    @deleteBtn.addClass('disabled').removeClass('btn-danger')

$.fn.actsAsMediaTable = () ->
  @each ->
    checkboxable = new Checkboxable($(this))
    new MediaTable($(this), checkboxable)

jQuery ->
  $("table.assets.js-checkboxable").each ->
    $(this).actsAsMediaTable()