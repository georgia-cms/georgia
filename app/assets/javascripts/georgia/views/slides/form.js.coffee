class Georgia.Views.SlideForm extends Backbone.View
  template: JST['slides/form']
  className: 'slide-form'

  events:
    'click #submit': 'save'

  initialize: (options) ->
    @panel = options.panel
    @images = options.images
    @locales = options.locales
    @contents = @model.get('contents')
    if @contents.length == 0 and @locales.length
      $.each @locales, (index, lang) =>
        @contents.add([{locale: lang}])

  render: ->
    $(@el).html(@template(slide: @model))
    view = new Georgia.Views.ContentsForm(collection: @contents, images: @images)
    @$('#contents_panel').html(view.render().el)
    this

  save: (event) ->
    event.preventDefault()
    @model.save @model.attributes,
      success: @handleSuccess
      error: @panel.handleError

  handleSuccess: (slide, response) =>
    @panel.swapPanels()
    @panel.appendSlide(@model)
    @panel.notify("<em>#{slide.get('title')}</em> has been updated.")