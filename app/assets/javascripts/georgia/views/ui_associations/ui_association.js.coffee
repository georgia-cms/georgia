class Georgia.Views.UiAssociation extends Backbone.View
  template: JST['ui_associations/ui_association']
  className: 'ui_association'

  events:
    'click .remove_icon': 'remove'

  initialize: ->
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(ui_association: @model)).fadeIn(500)
    this

  remove: (event) ->
    event.preventDefault()
    @model.destroy
      success: (model, response) => $(@el).fadeOut(500, -> $(this).remove())