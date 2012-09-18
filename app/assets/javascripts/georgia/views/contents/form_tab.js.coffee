class Georgia.Views.ContentsFormTab extends Backbone.View
  template: JST['contents/form_tab']
  tagName: 'li'

  render: ->
    $(@el).html(@template(content: @model))
    this