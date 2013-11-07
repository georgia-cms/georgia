class @MenuForm

  constructor: (element) ->
    @element = $(element)
    @links = @element.find('li')
    @addLinkBtn = $('.js-add-link')
    @treeInput = $('.js-menu-ancestry')
    @setBindings()

  setBindings: () =>
    @addLinkBtn.on('click', @addLink)
    @loadPortlets()
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

  loadPortlets: =>
    $.each(@links, -> new LinkPortlet($(this)))

  addLink: (event) =>
    event.preventDefault()
    $('.blank-state').remove()
    $.ajax(
      url: "/admin/links/new"
    ).done( (data) =>
      @element.append(data)
      portlet = $("#{$(data).attr('id')}")
      new LinkPortlet(portlet)
    )

$.fn.menuForm = () ->
  @each ->
    new MenuForm($(this))

jQuery ->
  $('.js-nested-sortable').each () ->
    $(this).menuForm()