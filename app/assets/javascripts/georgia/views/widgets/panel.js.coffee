##= require ../shared/panel.js.coffee
class Georgia.Views.WidgetsPanel extends Georgia.Views.Panel
  template: JST['widgets/panel']

  initialize: (options) ->
    @images = options.images
    @locales = $(@el).data('locales').split(',')
    @ui_sections = new Georgia.Collections.UiSections()
    @collection.on('reset', @render, this)
    @collection.on('add', @renderForm, this)

  render: ->
    $(@el).html(@template())
    @ui_sections.fetch(
      data: {page_id: $('[data-revision-id]').data('revision-id')}
      success: () =>
        @ui_sections.each(@appendUiSection)
    )
    @collection.each(@appendWidget)
    this

  appendWidget: (widget) =>
    view = new Georgia.Views.Widget(model: widget, images: @images, panel: @)
    @$('#widgets_list').append(view.render().el)

  appendUiSection: (ui_section) =>
    view = new Georgia.Views.UiSection(model: ui_section, collection: ui_section.get('ui_associations'), panel: @)
    $('#ui_sections').append(view.render().el)

  renderForm: (widget) =>
    view = new Georgia.Views.WidgetForm(model: widget, images: @images, locales: @locales, panel: @)
    @$('.form').html(view.render().el)
    @activateTabs()