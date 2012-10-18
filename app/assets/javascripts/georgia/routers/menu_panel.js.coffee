class Georgia.Routers.MenuPanel extends Backbone.Router
  routes:
    "": "index"

  initialize: ->
    @pages = new Georgia.Collections.Pages()
    @pages.fetch()

  index:  ->
    @links = new Georgia.Collections.Links()
    new Georgia.Views.MenuPanel(el: '#menu_panel', collection: @links, pages: @pages)
    @links.fetch({data: {menu_id: $('#menu_panel').data('menu-id')}})