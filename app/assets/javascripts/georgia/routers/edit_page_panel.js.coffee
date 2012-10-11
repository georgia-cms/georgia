class Georgia.Routers.EditPagePanel extends Backbone.Router
  routes:
    "": "index"

  initialize: ->
    @ui_sections = new Georgia.Collections.UiSections()
    @ui_sections.fetch({data: {page_id: $('#widgets').closest('form').data('page-id')}})

    @images = new Georgia.Collections.Images()
    @images.fetch()

  index:  ->
    @slides = new Georgia.Collections.Slides()
    new Georgia.Views.SlideshowPanel(el: '#slideshow', collection: @slides, images: @images)
    @slides.fetch({data: {page_id: $('#slideshow').closest('form').data('page-id')}})

    @widgets = new Georgia.Collections.Widgets()
    new Georgia.Views.WidgetsPanel(el: '#widgets', collection: @widgets, images: @images, ui_sections: @ui_sections)
    @widgets.fetch()