class Georgia.Views.ContentsForm extends Backbone.View
  template: JST['contents/form']
  className: 'tabbable'

  initialize: (options) ->
    @images = options.images

  render: ->
    $(@el).html(@template())
    @collection.each(@appendFormTab)
    @collection.each(@appendFormContent)
    this

  appendFormTab: (content, index) =>
    view = new Georgia.Views.ContentsFormTab(model: content)
    @$('#form_tabs').append(view.render().el)

  appendFormContent: (content) =>
    view = new Georgia.Views.ContentsFormContent(model: content, images: @images)
    @$('#form_contents').append(view.render().el)