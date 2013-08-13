class Georgia.Routers.EditPagePanel extends Backbone.Router
  routes:
    "": "index"

  initialize: ->
    @images = new Georgia.Collections.Images()
    @images.fetch()

  index:  ->
    @slides = new Georgia.Collections.Slides()
    new Georgia.Views.SlideshowPanel(el: '#slideshow', collection: @slides, images: @images)
    @slides.fetch({data: {page_id: $('[data-revision-id]').data('revision-id')}})

    @widgets = new Georgia.Collections.Widgets()
    @widgets.fetch()
    new Georgia.Views.WidgetsPanel(el: '#widgets', collection: @widgets, images: @images)