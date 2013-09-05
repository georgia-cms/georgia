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