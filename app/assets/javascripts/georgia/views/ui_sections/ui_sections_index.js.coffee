class Georgia.Views.UiSectionsIndex extends Backbone.View
  template: JST['ui_sections/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    @collection.each(@appendUiSection)
    this

  appendUiSection: (ui_section) =>
    view = new Georgia.Views.UiSection(model: ui_section)
    $('#ui_sections').append(view.render().el)