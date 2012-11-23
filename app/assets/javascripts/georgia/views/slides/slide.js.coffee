class Georgia.Views.Slide extends Backbone.View
  template: JST['slides/slide']
  tagName: 'li'
  className: 'slide'

  events:
    'click .bb-edit': 'edit'
    'click .bb-remove': 'remove'

  initialize: (options) ->
    @panel = options.panel
    @images = options.images
    console.log @model
    @id = 'slide_' + @model.id
    $(@el).attr 'id', @id
    $(@el).addClass(@model.attributes.type)
    $(@el).attr('data-slide-id', @model.id)
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(slide: @model)).fadeIn(500)
    this

  edit: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @panel.swapPanels()
    @panel.renderForm(@model)

  remove: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @model.destroy
      success: (slide, response) =>
        $(@el).fadeOut(500, -> $(this).remove())
        @panel.notify("<em>#{slide.get('title')}</em> has been deleted.")