class Georgia.Views.UiSection extends Backbone.View
  template: JST['ui_sections/ui_section']
  tagName: 'fieldset'

  # collection refers to ui_associations
  initialize: (options) ->
    @panel = options.panel
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(ui_section: @model))
    @$('.ui_association_list').droppable
      tolerance: 'touch'
      activeClass: "ui-state-default"
      hoverClass: "ui-state-hover"
      drop: ( event, ui ) =>
        ui.draggable.draggable('option','revert',true)
        @createUiAssociation(event, ui)
    @collection.each(@appendUiAssociation)
    this

  appendUiAssociation: (ui_assoc) =>
    view = new Georgia.Views.UiAssociation(model: ui_assoc, panel: @panel)
    @$('.ui_association_list').append(view.render().el)

  createUiAssociation: (event, ui) =>
    event.preventDefault()
    @collection.create({
        widget_id: $(ui.draggable).data('widget-id')
        page_id: $('[data-page-id]').data('page-id')
        ui_section_id: @model.id
      },
      success: (model, xhr, options) =>
        @appendUiAssociation(model)
        @panel.notify("#{model.get('title')} widget has been successfully added.", 'success')
      error: @panel.handleError
    )
