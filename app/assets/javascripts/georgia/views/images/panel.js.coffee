##= require ../shared/panel.js.coffee
class Georgia.Views.ImagesPanel extends Georgia.Views.Panel
  template: JST['images/panel']

  initialize: (options) ->
    @featured_image = options.featured_image
    @featured_image ?= new Georgia.Models.Image
    @position = 0

  render: ->
    $(@el).html(@template())
    @collection.each(@appendImage)
    @markFeatured()
    this

  appendImage: (image) =>
    view = new Georgia.Views.Image(model: image, content: @model)
    @$('.bb-thumbnails').append(view.render().el)


  markFeatured: () =>
    $(@el).find(".image-#{@featured_image.id}").addClass('featured')
    $(@el).find(".image-#{@featured_image.id}").find('.bb-star > i').toggleClass('icon-star icon-star-empty')
