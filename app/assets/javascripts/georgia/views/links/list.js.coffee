class Georgia.Views.LinksList extends Backbone.View
  template: JST['links/list']

  events:
    'click .bb-new': 'new'

  initialize: (options) ->
    @panel = options.panel
    @menu_id = $('[data-menu-id]').data('menu-id')
    @collection.on('add', @panel.renderForm, this)

  new: (event) ->
    event.preventDefault()
    @collection.add([{menu_id: @menu_id}])
    this

  addLinkFromPage: (page) ->
    contents = page.get('contents').map (content) ->
      {
        locale: content.get('locale')
        title: content.get('title')
        text: page.get('url')
      }
    @collection.add([{menu_id: @menu_id, contents: contents}])
    @panel.swapPanels()

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