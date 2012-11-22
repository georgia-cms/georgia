class Georgia.Views.Widget extends Backbone.View
  template: JST['widgets/widget']
  tagName: 'li'
  className: 'widget'

  events:
    'click .bb-edit': 'edit'
    'click .bb-remove': 'remove'

  initialize: (options) ->
    @panel = options.panel
    @images = options.images
    @id = 'widget_' + @model.id
    $(@el).attr 'id', @id
    $(@el).addClass(@model.attributes.type)
    $(@el).attr('data-widget-id', @model.id)
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(widget: @model)).fadeIn(500)
    $(@el).draggable
      revert: 'invalid'
      stack: '#widgets'
      scroll: false
      stop: -> $(this).draggable('option','revert','invalid')
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
      success: (widget, response) =>
        $(@el).fadeOut(500, -> $(this).remove())
        @panel.notify("<em>#{widget.get('title')}</em> has been deleted.")