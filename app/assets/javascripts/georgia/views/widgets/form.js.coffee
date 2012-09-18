class Georgia.Views.WidgetForm extends Backbone.View
  template: JST['widgets/form']
  className: 'widget-form'

  events:
    'click #submit': 'save'

  initialize: (options) ->
    @panel = options.panel
    @images = options.images
    @contents = @model.get('contents')
    @contents.add([{locale: 'en'}, {locale: 'fr'}]) if @contents.length == 0

  render: ->
    $(@el).html(@template(widget: @model))
    view = new Georgia.Views.ContentsForm(collection: @contents, images: @images)
    @$('#contents_panel').html(view.render().el)
    this

  save: (event) ->
    event.preventDefault()
    @model.save @model.attributes,
      success: @handleSuccess
      error: @handleError

  handleSuccess: (widget, response) =>
    @panel.swapPanels()
    @model.trigger('reset')

  handleError: (widget, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages