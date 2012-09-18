class Georgia.Views.ContentsFormContent extends Backbone.View
  template: JST['contents/form_content']
  className: 'tab-pane'

  events:
    'change input': 'attributeChanged'
    'change textarea': 'attributeChanged'

  initialize: (options) ->
    $(@el).attr 'id', "content_#{@model.cid}"
    @images = options.images
    @model.on('updateImage', @updateImage, this)

  render: ->
    $(@el).html(@template(content: @model))    
    view = new Georgia.Views.ImagesPanel(collection: @images, model: @model)
    @$('#images_panel').html(view.render().el)
    this

  attributeChanged: (event) ->
    event.preventDefault()
    field = $(event.currentTarget)
    @model.set(field.attr('id'), field.val())

  updateImage: (image_id) =>
    @model.set('image_id', image_id)