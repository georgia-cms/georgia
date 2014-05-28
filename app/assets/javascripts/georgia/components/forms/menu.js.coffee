class @MenuForm

  constructor: (element) ->
    @element = $(element)
    @links = @element.find('li')
    @addLinkBtn = $('.js-add-link')
    @treeInput = $('.js-menu-ancestry')
    @setBindings()

  setBindings: () =>
    @bindAddLink()
    @bindRemoveLink()
    @loadPortlets()
    @loadNestedSortable()

  loadPortlets: =>
    $.each(@links, -> new LinkPortlet($(this)))

  addLink: (event) =>
    event.preventDefault()
    $('.blank-state').remove()
    $.ajax(type: 'POST', url: "/admin/links", data: {menu_id: @element.data('menu-id')} )
      .done( (data) =>
        @element.append(data)
        portlet = $(data)
        new LinkPortlet(portlet)
      )

  removeLink: (event) =>
    event.preventDefault()
    portlet = $(event.currentTarget).closest('.portlet')
    portlet.find('input.js-destroy').val('1')
    portlet.hide()

  bindRemoveLink: () =>
    $('body').on('click', '.js-remove-link', @removeLink)

  bindAddLink: () =>
    @addLinkBtn.on('click', @addLink)

  loadNestedSortable: () =>
    @element.nestedSortable(
      forcePlaceholderSize: true
      items: 'li'
      handle: '.handle'
      helper: 'clone'
      opacity: .6
      placeholder: 'placeholder'
      revert: 250
      tabSize: 25
      tolerance: 'pointer'
      maxLevels: 3
      isTree: true
      expandOnHover: 700
      startCollapsed: true
      update: () =>
        @treeInput.val(@element.nestedSortable('serialize'))
    )

$.fn.menuForm = () ->
  @each ->
    new MenuForm($(this))

jQuery ->
  $('.js-nested-sortable').each () ->
    $(this).menuForm()