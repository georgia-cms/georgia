class @NestedWidget

  constructor: (element) ->
    @element = $(element)
    @widgetList = @element.find('.js-sortable')
    @selectTag  = @element.find('select')

    @setBindings()

  setBindings: () =>
    @element.on('click', '.js-add-widget', @addWidget)
    @element.on('click', '.js-remove-widget', @removeWidget)

  getWidgetId: () =>
    @selectTag.val()

  getData: () =>
    ui_section_id: @element.data('ui-section')
    revision_id: @element.data('revision')
    widget_id: @getWidgetId()

  addWidget: (event) =>
    event.preventDefault()
    $.ajax(
      url: "/admin/ui-associations/new"
      data: @getData()
    ).done( (data) => @widgetList.append(data) )

  removeWidget: (event) =>
    event.preventDefault()
    portlet = $(event.currentTarget).closest('.portlet')
    portlet.find('input.js-destroy').val('1')
    portlet.hide()



$.fn.nestedWidget = () ->
  @each ->
    new NestedWidget($(this))

jQuery ->
  $(".js-nested-widgets").each () ->
    $(this).nestedWidget()