jQuery ->

  $('.js-allow-slug-edit').click (event) ->
    $('#page_slug').attr('disabled', false)
    $('#page_slug').val($('#page_slug').data('slug'))
    $('#page_slug').focus()