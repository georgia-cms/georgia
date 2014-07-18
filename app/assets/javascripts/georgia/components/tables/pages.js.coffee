class @PagesTable extends @Table

  constructor: (element, checkboxable) ->
    super(element, checkboxable)
    @deleteBtn    = @element.find('.js-delete')
    @publishBtn   = @element.find('.js-publish')
    @unpublishBtn = @element.find('.js-unpublish')
    @setBindings()

  setBindings: () =>
    @deleteBtn.on('click', @destroy)
    @publishBtn.on('click', @publish)
    @unpublishBtn.on('click', @unpublish)

  destroy: (event) =>
    @stopEvent(event)
    $.ajax(
      type: 'DELETE'
      dataType: 'JSON'
      url: "/admin/pages"
      data: {id: @getIds()}
      success: @removePages
    ).always(@notify)

  publish: (event) =>
    @stopEvent(event)
    $.ajax(
      type: "POST"
      dataType: 'JSON'
      url: "/admin/pages/publish"
      data: {id: @getIds()}
      success: @markAsPublic
    ).always(@notify)

  unpublish: (event) =>
    @stopEvent(event)
    $.ajax(
      type: "POST"
      dataType: 'JSON'
      url: "/admin/pages/unpublish"
      data: {id: @getIds()}
      success: @markAsPrivate
    ).always(@notify)

  removePages: () =>
    $.each @getIds(), (index, id) -> $("#page_#{id}").remove()

  markAsPublic: () =>
    $.each @getIds(), (index, id) -> $("#page_#{id}").removeClass('private').addClass('public')

  markAsPrivate: () =>
    $.each @getIds(), (index, id) -> $("#page_#{id}").removeClass('public').addClass('private')

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

$.fn.actsAsPagesTable = () ->
  @each ->
    checkboxable = new Checkboxable($(this))
    new PagesTable($(this), checkboxable)

jQuery ->
  $("table.pages.js-checkboxable").each ->
    $(this).actsAsPagesTable()