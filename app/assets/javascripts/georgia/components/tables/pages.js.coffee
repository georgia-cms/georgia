class @PagesTable

  constructor: (element, checkboxable) ->
    @element      = $(element)
    @checkboxable = checkboxable
    @deleteBtn    = $('.js-delete')
    @publishBtn   = $('.js-publish')
    @unpublishBtn = $('.js-unpublish')
    @setBindings()

  checkboxes: () -> @element.find("input:checkbox")

  setBindings: () =>
    @element.on('click', @checkboxes(), @update)
    @deleteBtn.on('click', @destroy)
    @publishBtn.on('click', @publish)
    @unpublishBtn.on('click', @unpublish)

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
      @checkboxable.uncheck(@checkboxable.selectAllCheckbox)
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

  disableActions: () =>
    @deleteBtn.addClass('disabled').removeClass('btn-danger')
    @publishBtn.addClass('disabled').removeClass('btn-warning')
    @unpublishBtn.addClass('disabled').removeClass('btn-warning')

  stopEvent: (event) ->
    event.stopPropagation()
    event.preventDefault()

  getChecked: () => @element.find("input:checkbox:checked")
  getId:      (c) => $(c).data('id')
  getIds:     () => $.map(@getChecked(), (c) => @getId(c))

$.fn.actsAsPagesTable = () ->
  @each ->
    checkboxable = new Checkboxable($(this))
    new PagesTable($(this), checkboxable)

jQuery ->
  $("table.pages.js-checkboxable").each ->
    $(this).actsAsPagesTable()