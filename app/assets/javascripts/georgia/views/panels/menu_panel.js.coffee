##= require ./panel.js.coffee
class Georgia.Views.MenuPanel extends Georgia.Views.Panel
  template: JST['panels/menu']
  el: '#menu_panel'

  events:
    'click .bb-refresh': 'refresh'
    'click .bb-save': 'save'
    'click .swap-panel': 'swapPanels'
    'keydown .bb-search': 'search'

  initialize: (options) ->
    @locales = $(@el).data('locales').split(',')
    @links = @model.get('links')
    @list = new Georgia.Views.LinksList(collection: @links, panel: @)
    @pages = new Georgia.Collections.Pages
    @results = new Georgia.Views.PageMenuResults(collection: @pages, panel: @, list: @list)

  save: () =>
    @model.save {tree: @$('.sortable').nestedSortable('toArray', {startDepthCount: 0})},
      success: () =>
        @notify("#{@model.get('name')} menu has been successfully updated.", 'success')
      error: @handleError

  search: (event) =>
    @pages.search($('.bb-search').val(),
      error: @handleError
    )

  renderLinks: =>
    $(@el).html(@template(@model.attributes))
    @$('#links_list').html(@list.render().el)

  renderForm: (link) =>
    view = new Georgia.Views.LinkForm(model: link, locales: @locales, panel: @, list: @list)
    $('#link_form').html(view.render().el)
    @activateTabs()

  refresh: (event) ->
    event.preventDefault()
    $(@el).html("<i class='icon-spinner icon-spin'></i> Reloading...")
    @model.fetch(
      success: (model, response, options) ->
        @panel = new Georgia.Views.MenuPanel(model: model)
        @panel.render()
    )