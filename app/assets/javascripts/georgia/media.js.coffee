jQuery ->

  Shadowbox.init({})

  $('input.js-token-input').each (index, element) ->
    $(element).select2(
      placeholder: 'Enter tags'
      tags: $('#tags .js-tag').map () -> $(this).text() #once ininitialized, this list stays static. FIXME: either ajax or force refresh.
      multiple: true
      tokenSeparators: [",", " "]
    ).on('change', (e) -> $(element).closest('form').submit())

  # Initialize the jQuery File Upload widget:
  $('#fileupload').fileupload()

  # set options here!
  $('#fileupload').fileupload('option',
    maxFileSize: 2000000,
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
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