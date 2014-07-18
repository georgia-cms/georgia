class @Table

  constructor: (element, checkboxable) ->
    @element      = $(element)
    @actions      = @element.find('th.actions > a')
    @checkboxable = checkboxable
    @element.on('click', @checkboxes(), @update)

  checkboxes: () -> @element.find("input:checkbox")

  update: () =>
    if @getChecked().length then @enableActions() else @disableActions()

  notify: (data) =>
    new Flash(data['message'], data['status'])
    @checkboxable.updateSelectAll()

  enableActions: () =>
    @actions.removeClass('disabled').addClass('btn-info')

  disableActions: () =>
    @actions.addClass('disabled').removeClass('btn-info')

  stopEvent: (event) ->
    event.stopPropagation()
    event.preventDefault()

  getChecked: () => @element.find("input:checkbox:checked")
  getId:      (c) => $(c).data('id')
  getIds:     () => $.map(@getChecked(), (c) => @getId(c))