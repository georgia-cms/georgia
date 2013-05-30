jQuery ->

  $('select#per').change (e) ->
    $(this).closest('form').submit()

  $('#new_page').on('shown', -> $('input#page_title').focus())

  $('#subpages').sortable
    axis: 'y'
    update: ->
      $.post($(this).data('sort-url'), $(this).sortable('serialize'))
  .disableSelection()

  $('#templates .template').click ->
    $('#templates .template').removeClass('active')
    $(this).addClass('active')
    $('input#page_template').val($(this).attr('id'))

  $('.js-allow-slug-edit').click (event) ->
    slug = $(this).parent().siblings('input')
    $(slug).attr('disabled', false)
    $(slug).val($(slug).data('slug'))
    $(slug).focus()