class Georgia.Views.Message extends Backbone.View
  template: JST['shared/message']

  initialize: (options) ->
    @message = options.message
    @status = options.status
    $(@el).addClass("alert alert-#{@status}")

  render: ->
    $(@el).html(@template(message: @message)).fadeIn(500)
    this