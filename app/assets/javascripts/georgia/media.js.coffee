jQuery ->

  $('.js-file-upload').fileupload(
    dataType: 'jsonp'
    add: (e, data) ->
      data.submit()
      $('.btn-file-upload-text').html("<i class='fa fa-spinner fa-spin'></i> Uploading...")
  )

  # We use fileuploadalways callback because the response from the server is not accepted as successful
  # See other callbacks here: https://github.com/blueimp/jQuery-File-Upload/wiki/Options#callback-options
  $('.js-file-upload').on('fileuploadalways', (e, data) ->
    $('.btn-file-upload-text').html("<i class='fa fa-check'></i> Uploaded")
    setTimeout(
      -> $('.btn-file-upload-text').html("<i class='fa fa-plus'></i> Select files...")
      1500
    )
  )