jQuery ->

  $('.js-toggle-icon').hover -> $(this).siblings('i').toggleClass('hide')
  $('.js-toggle-children').click -> $(this).children().toggleClass('hide')