jQuery ->

  Shadowbox.init()

  # Submit form automatically when adding or removing tags
  # FIXME: Could this cause the lag on Firefox?
  if $('#media input.js-token-input').length
    $('#media input.js-token-input').on('change', (e) -> $(this).closest('form').submit())

  $('.js-file-upload').fileupload(
    dataType: 'jsonp'
    add: (e, data) ->
      data.submit()
      $('.btn-file-upload-text').html("<i class='icon-spinner icon-spin'></i> Uploading...")
  )