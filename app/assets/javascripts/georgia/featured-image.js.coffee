jQuery ->

  $('.js-featured-image').each (index, e) ->
    $(".js-toggle-image[data-image-id=#{$(e).val()}]").addClass('active')

  $('.js-toggle-image').click (e) ->
    e.preventDefault()
    $('.js-toggle-image').removeClass('active')
    $(this).addClass('active')
    input = $(this).closest('.tab-pane').find('.js-featured-image')
    input.val($(this).data('image-id'))