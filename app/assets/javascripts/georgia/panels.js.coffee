window.Georgia =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Georgia.Routers.EditPagePanel()
    Backbone.history.start()
  initMenuPanel: ->
    new Georgia.Routers.MenuPanel()
    Backbone.history.start()