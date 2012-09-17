jQuery ->
  $('#subpages').sortable
    axis: 'x'
    update: ->
      $.post($(this).data('sort-url'), $(this).sortable('serialize'))
  .disableSelection()