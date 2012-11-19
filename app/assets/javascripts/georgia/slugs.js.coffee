jQuery ->
  $('.js-allow-slug-edit').click (event) ->
    slug = $(this).parent().prev()
    $(slug).attr('disabled', false)
    $(slug).val($('#page_slug').data('slug'))
    $(slug).focus()