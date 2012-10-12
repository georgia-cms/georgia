class Georgia.Views.Slide extends Backbone.View
  template: JST['slides/slide']
  tagName: 'li'
  className: 'slide'

  events:
    'click .edit_icon': 'edit'
    'click .remove_icon': 'remove'

  initialize: (options) ->
    @panel = options.panel
    @images = options.images
    @id = 'slide_' + @model.id
    $(@el).attr 'id', @id
    $(@el).addClass(@model.attributes.type)
    $(@el).attr('data-slide-id', @model.id)
    $(@el).css('background', "url('#{@model.image}') no-repeat scroll 0 0 #08C") if @model.image
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
      success: (model, response) => $(@el).fadeOut(500, -> $(this).remove())