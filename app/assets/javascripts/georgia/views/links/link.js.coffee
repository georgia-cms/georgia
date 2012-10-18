class Georgia.Views.Link extends Backbone.View
  template: JST['links/link']
  className: 'link portlet accordion-group'

  events:
    'click .bb-edit': 'edit'
    'click .bb-remove': 'remove'
    'change .bb-dropdown': 'dropdownChanged'

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

  dropdownChanged: (event) ->
    event.stopPropagation()
    field = $(event.currentTarget)
    @model.set(field.attr('id'), field.prop('checked'))
    @update()

  update: () ->
    @model.save @model.attributes,
      success: @panel.handleSuccess
      error: @panel.handleError

  remove: (event) =>
    event.preventDefault()
    event.stopPropagation()
    @model.destroy
      success: (link, response) =>
        $(@el).fadeOut(500, -> $(this).remove())
        @panel.notify("<em>#{link.get('title')}</em> has been deleted.")