class Georgia.Views.UiAssociation extends Backbone.View
  template: JST['ui_associations/ui_association']
  className: 'ui_association'

  events:
    'click .remove_icon': 'remove'

  initialize: (options) ->
    @panel = options.panel

  render: ->
    $(@el).html(@template(@model.attributes)).fadeIn(500)
    this

  remove: (event) ->
    event.preventDefault()
    @model.destroy
      success: (model, response, options) =>
        $(@el).fadeOut(300, -> $(this).remove())
        @panel.notify("<em>#{model.get('title')}</em> association has been deleted.")