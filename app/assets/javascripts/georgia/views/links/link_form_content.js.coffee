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
    @$('#text').autocomplete(
      source: '/api/pages/urls'
      minLength: 2
      select: (event, ui) =>
        event.preventDefault()
        event.stopPropagation()
        @$('#text').val(ui.item.url)
      )
    .data('ui-autocomplete')._renderItem = ( ul, item ) ->
      return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( "<a>" + item.url + "</a>" )
        .appendTo( ul )
    this

  attributeChanged: (event) ->
    event.preventDefault()
    field = $(event.currentTarget)
    @model.set(field.attr('id'), field.val())