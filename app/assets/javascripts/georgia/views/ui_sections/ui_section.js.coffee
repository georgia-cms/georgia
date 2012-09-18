class Georgia.Views.UiSection extends Backbone.View
  template: JST['ui_sections/ui_section']
  tagName: 'fieldset'

  initialize: ->
    @ui_associations = @model.get('ui_associations')
    @model.on('change', @render, this)
    @ui_associations.on('add', @appendUiAssociation, this)

  render: ->
    $(@el).html(@template(ui_section: @model))
    @$('.ui_association_list').droppable
      tolerance: 'touch'
      activeClass: "ui-state-default"
      hoverClass: "ui-state-hover"
      drop: ( event, ui ) =>
        ui.draggable.draggable('option','revert',true)
        @createUiAssociation(event, ui)
    @ui_associations.each(@appendUiAssociation)
    this

  appendUiAssociation: (ui_assoc) =>
    view = new Georgia.Views.UiAssociation(model: ui_assoc)
    @$('.ui_association_list').append(view.render().el)

  createUiAssociation: (event, ui) ->
    event.preventDefault()
    attributes = 
      widget_id: $(ui.draggable).data('widget-id')
      ui_section_id: @model.id
      page_id: $(@el).closest('form').data('page-id')
    @ui_associations.create {ui_association: attributes},
      wait: true
      error: @handleError

  handleError: (ui_assoc, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages