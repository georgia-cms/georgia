jQuery ->

  $("[data-featured-image='toggle']").click (e) ->
    e.preventDefault()
    pane = $(this).closest('.tab-pane')
    pane.find("[data-featured-image='toggle']").removeClass('active')
    $(this).addClass('active')
    pane.find("[data-featured-image='input']").val($(this).data('featured-image-id'))