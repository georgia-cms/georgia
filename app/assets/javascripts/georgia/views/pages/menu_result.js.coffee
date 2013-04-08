class Georgia.Views.PageMenuResult extends Backbone.View
  template: JST['pages/menu_result']
  tagName: 'li'

  events:
    'click .bb-add': 'add'

  initialize: (options) ->
    @list = options.list
    @panel = options.panel

  add: (event) ->
    event.preventDefault()
    @list.addLinkFromPage(@model)

  render: ->
    $(@el).html(@template(@model.attributes))
    this