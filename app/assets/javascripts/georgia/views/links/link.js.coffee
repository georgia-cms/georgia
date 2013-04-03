class Georgia.Views.Link extends Backbone.View
  template: JST['links/link']
  tagName: 'li'

  events:
    'click .bb-edit': 'edit'
    'click .bb-remove': 'remove'

  initialize: (options) ->
    @panel = options.panel
    @id = 'link_' + @model.id
    $(@el).attr 'id', @id
    $(@el).addClass(@model.attributes.type)
    $(@el).attr('data-link-id', @model.id)
    @model.on('change:title', @render, this)
    @model.on('change:text', @render, this)

  render: ->
    $(@el).html(@template(@model.attributes)).fadeIn(500) unless @model.isNew()
    this

  edit: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @panel.swapPanels()
    @panel.renderForm(@model)

  remove: (event) =>
    event.preventDefault()
    event.stopPropagation()
    @model.destroy
      success: (link, response) =>
        $(@el).fadeOut(500, -> $(this).remove())
        @panel.notify("<em>#{link.get('title')}</em> has been deleted.")