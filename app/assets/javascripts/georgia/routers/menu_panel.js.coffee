class Georgia.Routers.MenuPanel extends Backbone.Router
  routes:
    "": "index"

  initialize: ->
    @menu = new Georgia.Models.Menu({id: $('#menu_panel').data('menu-id')})
    @menu.fetch()
    new Georgia.Views.MenuPanel(el: '#menu_panel', model: @menu)