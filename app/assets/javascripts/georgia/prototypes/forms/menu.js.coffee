class @MenuForm

  constructor: (element) ->
    @element = $(element)
    @links = @element.find('li')
    @setBindings()

  setBindings: () =>
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
    ).disableSelection()

  loadPortlets: =>
    $.each(@links, -> new LinkPortlet($(this)))

$.fn.menuForm = () ->
  @each ->
    new MenuForm($(this))

jQuery ->
  $('.js-nested-sortable').each () ->
    $(this).menuForm()