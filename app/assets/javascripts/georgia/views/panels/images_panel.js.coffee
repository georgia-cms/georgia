##= require ./panel.js.coffee
class Georgia.Views.ImagesPanel extends Georgia.Views.Panel
  template: JST['panels/images']

  events:
    'click .bb-prev': 'previous'
    'click .bb-next': 'next'

  initialize: (options) ->
    @featured_image = options.featured_image
    @featured_image ?= new Georgia.Models.Image
    @position = 0

  render: ->
    $(@el).html(@template())
    @collection.each(@appendImage)
    @enableLightBox()
    @markFeatured()
    @disableNextIfNeeded()
    this

  appendImage: (image) =>
    view = new Georgia.Views.Image(model: image, content: @model)
    @$('.bb-thumbnails').append(view.render().el)

  previous: (event) ->
    event.preventDefault()
    unless @$('.bb-prev').hasClass('disabled')
      @$('.bb-thumbnails').animate({top: '+=345px'}, 'fast')
      @$('.bb-next').removeClass('disabled')
      @position-=1
    @$('.bb-prev').addClass('disabled') if @reachStart()

  next: (event) ->
    event.preventDefault()
    unless @$('.bb-next').hasClass('disabled')
      @$('.bb-thumbnails').animate({top: '-=345px'}, 'fast')
      @$('.bb-prev').removeClass('disabled')
      @position+=1
    @$('.bb-next').addClass('disabled') if @reachEnd()

  reachStart: () ->
    @position is 0

  reachEnd: () ->
    @position >= parseInt(@collection.length/9)

  enableLightBox: () =>
    $(@el).find('.js-lightbox').lightBox()

  markFeatured: () =>
    $(@el).find(".image-#{@featured_image.id}").addClass('featured')
    $(@el).find(".image-#{@featured_image.id}").find('.bb-star > i').toggleClass('icon-star icon-star-empty')


  disableNextIfNeeded: ->
    @$('.bb-next').addClass('disabled') unless (@collection.length > 9)