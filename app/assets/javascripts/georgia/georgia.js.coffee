window.Georgia =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Georgia.Routers.EditPagePanel()
    Backbone.history.start()