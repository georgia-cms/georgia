class Georgia.Views.Page extends Backbone.View
  template: JST['pages/page']
  tagName: 'label'
  className: 'checkbox'

  render: ->
    $(@el).html(@template(page: @model))
    this
