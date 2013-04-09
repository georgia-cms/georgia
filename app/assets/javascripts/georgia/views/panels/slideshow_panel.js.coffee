class Georgia.Views.SlideshowPanel extends Georgia.Views.Panel
  template: JST['panels/slideshow']

  render: ->
    $(@el).html(@template())
    @collection.each(@appendSlide)
    @$('#slides_tabs').sortable
      axis: 'y'
      update: ->
        $.post('/api/slides/sort', $(this).sortable('serialize'))
    .disableSelection()
    this

  appendSlide: (slide) =>
    view = new Georgia.Views.Slide(model: slide, images: @images, panel: this)
    @$('#slides_tabs').append(view.render().el)

  new: (event) ->
    event.preventDefault()
    @collection.add([{page_id: $('[data-page-id]').data('page-id')}])
    this

  renderForm: (slide) =>
    view = new Georgia.Views.SlideForm(model: slide, images: @images, locales: @locales, panel: this)
    @$('.form').html(view.render().el)
    @activateTabs()