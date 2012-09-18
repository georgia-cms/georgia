class Georgia.Views.WidgetsPanel extends Georgia.Views.Panel
  template: JST['panels/widgets']

  initialize: (options) ->
    @images = options.images
    @ui_sections = options.ui_sections
    @collection.on('reset', @render, this)
    @collection.on('add', @renderForm, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendWidget)
    view = new Georgia.Views.UiSectionsIndex(collection: @ui_sections)
    @$('#ui_sections').append(view.render().el)
    this

  appendWidget: (widget) =>
    view = new Georgia.Views.Widget(model: widget, images: @images, panel: this)
    @$('#widgets_list').append(view.render().el)

  new: (event) ->
    event.preventDefault()
    @collection.add([{}])
    this

  renderForm: (widget) =>
    view = new Georgia.Views.WidgetForm(model: widget, images: @images, panel: this)
    @$('.form').html(view.render().el)
    @activateTabs()