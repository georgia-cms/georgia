class Georgia.Routers.MenuPanel extends Backbone.Router
  routes:
    "": "index"

  initialize: ->
    @menu = new Georgia.Models.Menu({id: $("[data-menu-id]").data('menu-id')})
    @menu.fetch(
      success: (model, response, options) ->
        @panel = new Georgia.Views.MenuPanel(model: model)
        @panel.render()
    )