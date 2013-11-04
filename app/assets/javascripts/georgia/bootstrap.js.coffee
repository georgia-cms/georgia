jQuery ->
  $('.js-focus').focus()
  $('.js-tooltip').tooltip()
  $('.js-sortable').sortable(axis: 'y')
  $('.js-nested-sortable').nestedSortable(
    forcePlaceholderSize: true
    handle: '.link-form'
    helper: 'clone'
    items: 'li'
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