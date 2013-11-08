class @MessagesTable

  constructor: (element) ->
    @element      = $(element)
    @checkboxes   = @element.find("input:checkbox")
    @deleteBtn    = @element.find('.js-delete')
    @spamBtn      = @element.find('.js-spam')
    @hamBtn       = @element.find('.js-ham')
    @setBindings()

  setBindings: () =>
    @checkboxes.on('click', @update)
    @deleteBtn.on('click', @delete)
    @spamBtn.on('click', @spam)
    @hamBtn.on('click', @ham)

  update: () =>
    if @getChecked().length then @showActions() else @hideActions()

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

  enableActions: () =>
    @spamBtn.removeClass('disabled')
    @hamBtn.removeClass('disabled')
    @deleteBtn.removeClass('disabled')

  disableActions: () =>
    @spamBtn.addClass('disabled')
    @hamBtn.addClass('disabled')
    @deleteBtn.addClass('disabled')

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