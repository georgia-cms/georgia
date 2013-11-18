class @PagesTable

  constructor: (element) ->
    @element      = $(element)
    @checkboxes   = @element.find("input:checkbox")
    @deleteBtn    = $('.js-delete')
    @publishBtn   = $('.js-publish')
    @unpublishBtn = $('.js-unpublish')
    @flushCacheBtn = $('.js-flush-cache')
    @setBindings()

  setBindings: () =>
    @checkboxes.on('click', @update)
    @deleteBtn.on('click', @destroy)
    @publishBtn.on('click', @publish)
    @unpublishBtn.on('click', @unpublish)
    @flushCacheBtn.on('click', @flushCache)

  update: () =>
    if @getChecked().length
      @enableActions()
    else
      @disableActions()

  destroy: (event) =>
    @stopEvent(event)
    $.ajax(
      type: 'DELETE'
      url: "/admin/pages"
      data: {id: @getIds()}
      dataType: 'JSON'
    ).always(() =>
      $.each @getIds(), (index, id) -> $("#page_#{id}").remove()
    )

  flushCache: (event) =>
    @stopEvent(event)
    $.ajax(
      type: "POST"
      url: "/admin/pages/flush-cache"
      data: {id: @getIds()}
      dataType: 'JSON'
    )

  publish: (event) =>
    @stopEvent(event)
    $.ajax(
      type: "POST"
      url: "/admin/pages/publish"
      data: {id: @getIds()}
      dataType: 'JSON'
    ).always(() =>
      $.each @getIds(), (index, id) -> $("#page_#{id}").removeClass('private').addClass('public')
    )

  unpublish: (event) =>
    @stopEvent(event)
    $.ajax(
      type: "POST"
      url: "/admin/pages/unpublish"
      data: {id: @getIds()}
      dataType: 'JSON'
    ).always(() =>
      $.each @getIds(), (index, id) -> $("#page_#{id}").addClass('private').removeClass('public')
    )

  enableActions: () =>
    @deleteBtn.removeClass('disabled').addClass('btn-danger')
    @publishBtn.removeClass('disabled').addClass('btn-warning')
    @unpublishBtn.removeClass('disabled').addClass('btn-warning')
    @flushCacheBtn.removeClass('disabled').addClass('btn-warning')

  disableActions: () =>
    @deleteBtn.addClass('disabled').removeClass('btn-danger')
    @publishBtn.addClass('disabled').removeClass('btn-warning')
    @unpublishBtn.addClass('disabled').removeClass('btn-warning')
    @flushCacheBtn.addClass('disabled').removeClass('btn-warning')

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