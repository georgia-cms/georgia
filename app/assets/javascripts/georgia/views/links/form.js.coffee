class Georgia.Views.LinkForm extends Backbone.View
  template: JST['links/form']
  className: 'link-form'

  events:
    'click .bb-create': 'create'
    'click .bb-update': 'update'

  initialize: (options) ->
    @panel = options.panel
    @locales = options.locales
    @contents = @model.get('contents')
    if @contents.length == 0 and @locales.length
      $.each @locales, (index, lang) =>
        @contents.add([{locale: lang}])

  render: ->
    $(@el).html(@template(link: @model, contents: @contents))
    @contents.each(@appendContentForm)
    this

  appendContentForm: (content) =>
    view = new Georgia.Views.LinksFormContent(model: content)
    @$('#form_contents').append(view.render().el)

  create: (event) ->
    event.preventDefault()
    @model.save @model.attributes,
      success: () =>
        @panel.swapPanels()
        @panel.appendLink(@model)
        @panel.notify("#{@model.get('title')} has been successfully created.", 'success')
      error: @panel.handleError

  update: (event) ->
    event.preventDefault()
    @model.save @model.attributes,
      success: () =>
        @panel.swapPanels()
        @panel.notify("#{@model.get('title')} has been successfully updated.", 'success')
      error: @panel.handleError