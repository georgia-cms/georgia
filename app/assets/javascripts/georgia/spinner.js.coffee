jQuery ->

  $('form.wait-and-spin').on('ajax:beforeSend', (event, xhr, settings) ->
    $("form.wait-and-spin [type='submit']").prop('disabled', true)
    $('form.wait-and-spin .spinner').show()
  )

  $('form.wait-and-spin').on('ajax:complete', (event, xhr, status) ->
    $("form.wait-and-spin [type='submit']").prop('disabled', false)
    $('form.wait-and-spin .spinner').hide()
  )