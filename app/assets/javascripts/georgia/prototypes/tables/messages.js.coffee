class @MessagesTable

  constructor: (element) ->
    @element      = $(element)
    @checkboxes   = @element.find("input:checkbox")
    @deleteBtn    = $('.js-delete')
    @spamBtn      = $('.js-spam')
    @hamBtn       = $('.js-ham')
    @setBindings()

  setBindings: () =>
    @checkboxes.on('click', @update)
    @deleteBtn.on('click', @delete)
    @spamBtn.on('click', @spam)
    @hamBtn.on('click', @ham)

  update: () =>
    if @getChecked().length
      @showActions()
    else
      @hideActions()

  delete: (event) =>
    @stopEvent(event)
    $.ajax(
      url: "/admin/messages/#{@getIds()}"
      type: 'DELETE'
    )

  spam: (event) ->
    @stopEvent(event)

  ham: (event) ->
    @stopEvent(event)

  showActions: () =>
    @spamBtn.removeClass('hide')
    @hamBtn.removeClass('hide')
    @deleteBtn.removeClass('hide')

  hideActions: () =>
    @spamBtn.addClass('hide')
    @hamBtn.addClass('hide')
    @deleteBtn.addClass('hide')

  stopEvent: (event) ->
    event.stopPropagation()
    event.preventDefault()

  getChecked: () => @element.find("input:checkbox:checked[data-checkbox='child']")
  getId:      (c) => $(c).data('id')
  getIds:     () => $.map(@getChecked(), (c) => @getId(c))

$.fn.actsAsMessagesTable = () ->
  @each ->
    new MessagesTable($(this))

jQuery ->
  $("table.messages.js-checkboxable").each ->
    $(this).actsAsMessagesTable()