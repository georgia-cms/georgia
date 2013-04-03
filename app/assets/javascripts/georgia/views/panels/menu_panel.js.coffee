##= require ./panel.js.coffee
class Georgia.Views.MenuPanel extends Georgia.Views.Panel
  template: JST['panels/menu']

  events:
    'click .bb-save': 'save'
    'click .bb-add-to-menu': 'create'
    'click .bb-new': 'new'
    'click .swap-panel': 'swapPanels'

  initialize: (options) ->
    @locales = $(@el).data('locales').split(',')
    @model.on('change', @render, this)
    # @model.get('links').on('reset', @render, this)
    # @model.get('links').on('add', @renderForm, this)

  create: (event) =>
    event.preventDefault()
    $('#pages input[type=checkbox]:checked').each (index, input) =>
      @model.get('links').create {page_id: $(input).val(), menu_id: $(@el).data('menu-id')},
        wait: true
        success: (link, response) =>
          @appendLink(link)
          @uncheckAll()
          @notify("<em>#{link.get('title')}</em> has been added to the menu.", 'success')
        error: @handleError
    this

  new: (event) ->
    event.preventDefault()
    @model.get('links').add([{menu_id: $(@el).data('menu-id')}])
    this

  save: () =>
    @model.save {tree: @$('.sortable').nestedSortable('toArray', {startDepthCount: 0})},
      success: () =>
        @notify("#{@model.get('name')} has been successfully updated.", 'success')
      error: @handleError
    @model.save

  render: ->
    $(@el).html(@template(@model.attributes))
    @model.get('links').each(@appendLink)
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
    view = new Georgia.Views.Link(model: link, panel: this)
    @$('#links').append(view.render().el)

  renderForm: (link) =>
    view = new Georgia.Views.LinkForm(model: link, locales: @locales, panel: this)
    @$('.form').html(view.render().el)
    @activateTabs()

  checkAll: () =>
    @$('#pages input[type=checkbox]').prop('checked', true)

  uncheckAll: () =>
    @$('#pages input[type=checkbox]').prop('checked', false)