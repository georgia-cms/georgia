jQuery ->

  Shadowbox.init()

  $('#media input.js-token-input').on('change', (e) -> $(this).closest('form').submit())

  # Initialize the jQuery File Upload widget:
  $('#fileupload').fileupload()

  # set options here!
  $('#fileupload').fileupload('option',
    maxFileSize: 2000000,
    maxNumberOfFiles: 50
  )

  # Load existing files:
  $.getJSON($('#fileupload').prop('action'), (files) ->
    fu = $('#fileupload').data('fileupload')
    fu._adjustMaxNumberOfFiles(-files.length)
    template = fu._renderDownload(files).appendTo($('#fileupload .files'))
    # Force reflow:
    fu._reflow = fu._transition && template.length && template[0].offsetWidth
    template.addClass('in')
    $('#loading').remove()
  )