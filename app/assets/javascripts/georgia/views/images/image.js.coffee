class Georgia.Views.Image extends Backbone.View
  template: JST['images/image']
  tagName: 'li'

  events:
    'click .thumbnail': 'preventDefault'
    'click .bb-star': 'setAsFeatured'
    'hover .bb-star': 'toggleStar'

  initialize: (options) ->
    @content = options.content
    $(@el).addClass("image-#{@model.id}")

  render: ->
    $(@el).html(@template(image: @model))
    this

  preventDefault: (event) =>
    event.preventDefault()

  setAsFeatured: (event) =>
    event.preventDefault()
    $(@el).siblings('.featured').find('.bb-star > i').toggleClass('icon-star icon-star-empty')
    $(@el).siblings('.featured').removeClass('featured')
    $(@el).addClass('featured')
    $(@el).find('.bb-star > i').removeClass('icon-star-empty')
    $(@el).find('.bb-star > i').addClass('icon-star')
    @content.trigger('updateImage', @model.id)

  toggleStar: (event) =>
    $(@el).find('.bb-star > i').toggleClass('icon-star icon-star-empty') unless $(@el).hasClass('featured')