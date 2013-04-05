class Georgia.Views.LinksList extends Backbone.View
  template: JST['links/list']

  events:
    'click .bb-new': 'new'

  initialize: (options) ->
    @panel = options.panel
    @collection.on('add', @panel.renderForm, this)

  new: (event) ->
    event.preventDefault()
    @collection.add([{menu_id: $('[data-menu-id]').data('menu-id')}])
    this

  render: ->
    $(@el).html(@template)
    @collection.each(@appendLink)
    @$('.sortable').nestedSortable(
      forcePlaceholderSize: true
      handle: 'div'
      helper: 'clone'
      items: 'li'
      opacity: .6
      placeholder: 'placeholder'
      revert: 250
      tabSize: 25
      tolerance: 'pointer'
      maxLevels: 3

      isTree: true
      expandOnHover: 700
      startCollapsed: true
    ).disableSelection()
    this

  appendLink: (link) =>
    view = new Georgia.Views.Link(model: link, panel: @panel)
    @$('.sortable').append(view.render().el)