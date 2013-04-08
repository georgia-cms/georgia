class Georgia.Views.PageMenuResults extends Backbone.View
  template: JST['pages/menu_results']

  initialize: (options) ->
    @panel = options.panel
    @list = options.list
    @collection.on('reset', @render, this)

  render: =>
    $('#page_results').html(@template)
    @collection.each(@appendResult)
    this

  appendResult: (page) =>
    view = new Georgia.Views.PageMenuResult(model: page, list: @list, panel: @panel)
    $('.results').append(view.render().el)