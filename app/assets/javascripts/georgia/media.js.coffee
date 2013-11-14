jQuery ->

  # We use fileuploadalways callback because the response from the server is not accepted as successful
  # See other callbacks here: https://github.com/blueimp/jQuery-File-Upload/wiki/Options#callback-options
  $('.js-file-upload').fileupload(dataType: 'jsonp')

  $('.js-file-upload').on('fileuploadadd', (e, data) ->
    data.submit()
  )

  $('.js-file-upload').on('fileuploadsend', (e, data) ->
    $('.btn-file-upload-text').html("<i class='fa fa-spinner fa-spin'></i> Uploading...")
    $('#progress').modal('show')
  )

  $('.js-file-upload').on('fileuploadalways', (e, data) ->
    $('#progress').modal('hide')
    $('.btn-file-upload-text').html("<i class='fa fa-check'></i> Uploaded")
    setTimeout(
      -> $('.btn-file-upload-text').html("<i class='fa fa-plus'></i> Select files...")
      1500
    )
  )

  $('.js-file-upload').on('fileuploadprogressall', (e, data) ->
    progress = parseInt(data.loaded / data.total * 100, 10)
    $('#progress .progress-bar')
      .css('width', "#{progress}%")
      .attr('aria-valuenow', "#{progress}%")
  )