class Georgia.Views.WidgetForm extends Backbone.View
  template: JST['widgets/form']
  className: 'widget-form'

  events:
    'click .bb-create': 'create'
    'click .bb-update': 'update'

  initialize: (options) ->
    @panel = options.panel
    @images = options.images
    @locales = options.locales
    @contents = @model.get('contents')
    if @contents.length == 0 and @locales.length
      $.each @locales, (index, lang) =>
        @contents.add([{locale: lang}])

  render: ->
    $(@el).html(@template(widget: @model))
    view = new Georgia.Views.ContentsForm(collection: @contents, images: @images)
    @$('#contents_panel').html(view.render().el)
    this

  create: (event) ->
    event.preventDefault()
    @model.save @model.attributes,
      success: () =>
        @panel.swapPanels()
        @panel.appendWidget(@model)
        @panel.notify("#{@model.get('title')} has been successfully created.", 'success')
      error: @panel.handleError

  update: (event) ->
    event.preventDefault()
    @model.save @model.attributes,
      success: () =>
        @panel.swapPanels()
        @panel.notify("#{@model.get('title')} has been successfully updated.", 'success')
      error: @panel.handleError