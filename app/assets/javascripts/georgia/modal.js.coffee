jQuery ->

  # Add data-backdrop='backdrop--white' for a white filter at the back
  $('.js-modal').click (e) ->
    e.preventDefault()
    $(this).addClass('is-open')

    target = $(this).attr('href')

    $(target).toggleClass('is-open')

    $('body').append("<div class='backdrop'></div>")

  $('body').on 'click', '.backdrop', (e) ->
    $('.is-open').removeClass('is-open')
    $(this).remove()

  $('.js-close').click (e) ->
    e.preventDefault()
    $('.is-open').removeClass('is-open')
    $('.backdrop').remove()
