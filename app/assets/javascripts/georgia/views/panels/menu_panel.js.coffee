##= require ./panel.js.coffee
class Georgia.Views.MenuPanel extends Georgia.Views.Panel
  template: JST['panels/menu']

  events:
    'click .bb-add-to-menu': 'create'
    'click .new-form': 'new'
    'click .swap-panel': 'swapPanels'

  initialize: (options) ->
    @pages = options.pages
    @locales = $(@el).data('locales').split(',')
    @collection.on('reset', @render, this)
    @collection.on('add', @renderForm, this)

  create: (event) =>
    event.preventDefault()
    $('#pages input[type=checkbox]:checked').each (index, input) =>
      @collection.create {page_id: $(input).val(), menu_id: $(@el).data('menu-id')},
        wait: true
        success: (link, response) =>
          @appendLink(link)
          @notify("<em>#{link.get('title')}</em> has been added to the menu.", 'success')
        error: @handleError
    this

  new: (event) ->
    event.preventDefault()
    @collection.add([{menu_id: $(@el).data('menu-id')}])
    this

  render: ->
    $(@el).html(@template())
    @pages.each(@appendPage)
    @collection.each(@appendLink)
    @$('#links').sortable
      update: ->
        $.post('/api/links/sort', $(this).sortable('serialize'))
    .disableSelection()
    this

  appendPage: (page) =>
    view = new Georgia.Views.Page(model: page, panel: this)
    @$('#pages').append(view.render().el)

  appendLink: (link) =>
    view = new Georgia.Views.Link(model: link, panel: this)
    @$('#links').append(view.render().el)

  renderForm: (link) =>
    view = new Georgia.Views.LinkForm(model: link, locales: @locales, panel: this)
    @$('.form').html(view.render().el)
    @activateTabs()