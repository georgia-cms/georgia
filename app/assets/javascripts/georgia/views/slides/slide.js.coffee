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
    @id = 'slide_' + @model.id
    @model.on('change', @render, this)

  render: ->
    $(@el).attr('id', @id).html(@template(@model.attributes)).fadeIn(500)
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