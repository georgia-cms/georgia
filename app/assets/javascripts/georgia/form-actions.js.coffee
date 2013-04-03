jQuery ->

  $('form.wait-and-spin').on('ajax:beforeSend', (event, xhr, settings) ->
    $("form.wait-and-spin [type='submit']").prop('disabled', true)
    $("form.wait-and-spin [type='submit']").html("<i class='icon-spinner icon-spin'>&nbsp;</i> Saving...")
  )

  $('form.wait-and-spin').on('ajax:success', (event, xhr, status) ->
    $("form.wait-and-spin [type='submit']").addClass('btn-info').html("<i class='icon-check'>&nbsp;</i> Saved")
  )

  $('form.wait-and-spin').on('ajax:complete', (event, xhr, status) ->
    setTimeout( ()->
        $("form.wait-and-spin [type='submit']").removeClass('btn-info').prop('disabled', false).html("<i class='icon-ok'>&nbsp;</i> Save")
      , 1500)
  )

  $(document).on('click', '.js-refresh', (e) ->
    e.preventDefault()
    location.reload()
  )