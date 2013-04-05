##= require ./panel.js.coffee
class Georgia.Views.MenuPanel extends Georgia.Views.Panel
  template: JST['panels/menu']
  el: '#menu_panel'

  events:
    'click .bb-refresh': 'refresh'
    'click .bb-save': 'save'
    'click .bb-add-to-menu': 'create'
    'click .swap-panel': 'swapPanels'

  initialize: (options) ->
    @locales = $(@el).data('locales').split(',')
    @list = new Georgia.Views.LinksList(collection: @model.get('links'), panel: @)
    # @model.on('change', @render, this)

  create: (event) =>
    event.preventDefault()
    $('#pages input[type=checkbox]:checked').each (index, input) =>
      @model.get('links').create {menu_id: $(@el).data('menu-id')},
        wait: true
        success: (link, response) =>
          @appendLink(link)
          @notify("<em>#{link.get('title')}</em> has been added to the menu.", 'success')
        error: @handleError
    this

  save: () =>
    @model.save {tree: @$('.sortable').nestedSortable('toArray', {startDepthCount: 0})},
      success: () =>
        @notify("#{@model.get('name')} menu has been successfully updated.", 'success')
      error: @handleError

  render: =>
    $(@el).html(@template(@model.attributes))
    @$('#links_list').html(@list.render().el)

  renderForm: (link) =>
    view = new Georgia.Views.LinkForm(model: link, locales: @locales, panel: @, list: @list)
    @$('#link_form').html(view.render().el)
    @activateTabs()

  refresh: (event) ->
    event.preventDefault()
    $(@el).html("<i class='icon-spinner icon-spin'></i> Reloading...")
    @model.fetch(
      success: (model, response, options) ->
        @panel = new Georgia.Views.MenuPanel(model: model)
        @panel.render()
    )