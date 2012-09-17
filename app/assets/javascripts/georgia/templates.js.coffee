jQuery ->
  $('#templates .template').click ->
    $('#templates .template').removeClass('active')
    $(this).addClass('active')
    $('input#page_template').val($(this).attr('id'))