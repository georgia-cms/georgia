class Georgia.Views.LinkFormContent extends Backbone.View
  template: JST['links/form_content']
  className: 'tab-pane'

  events:
    'change input': 'attributeChanged'
    'change textarea': 'attributeChanged'

  initialize: (options) ->
    $(@el).attr 'id', "content_#{@model.cid}"

  render: ->
    $(@el).html(@template(content: @model))
    this

  attributeChanged: (event) ->
    event.preventDefault()
    field = $(event.currentTarget)
    @model.set(field.attr('id'), field.val())