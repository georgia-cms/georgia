class Georgia.Views.Link extends Backbone.View
  template: JST['links/link']
  tagName: 'li'

  events:
    'click .bb-edit': 'edit'
    'click .bb-remove': 'remove'
    'click .disclose': 'disclose'

  # @model is a link
  # @collection are nested links
  initialize: (options) ->
    @panel = options.panel
    $(@el).attr('id', "link_#{@model.id}")
    @model.on('change:title', @render, this)
    @model.on('change:text', @render, this)

  render: ->
    $(@el).html(@template(@model.attributes)).fadeIn(500) unless @model.isNew()
    if @collection.length
      @collection.each(@appendNestedLink)
    this

  appendNestedLink: (link) =>
    view = new Georgia.Views.Link(model: link, collection: link.get('links'), panel: @panel)
    $(@el).append('<ol></ol>')
    $(@el).find('ol').first().append(view.render().el)

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
        @panel.notify("<em>#{link.get('title')}</em> link has been deleted.")

  disclose: (event) =>
    event.stopPropagation()
    $(event.target).closest('li').toggleClass('mjs-nestedSortable-collapsed').toggleClass('mjs-nestedSortable-expanded')