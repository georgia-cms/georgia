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

  # $('#new_picture').fileupload
  #   dataType: "script"
  #   add: (e, data) ->
  #     types = /(\.|\/)(gif|jpe?g|png)$/i
  #     file = data.files[0]
  #     if types.test(file.type) || types.test(file.name)
  #       data.context = $("<div id='#{file.size}'' class='upload'>#{file.name}<div class='progress progress-striped active'><div class='bar' style='width: 0%'></div></div></div>")
  #       $('#new_picture').prepend(data.context)
  #       data.submit()
  #     else
  #       $("#new_picture").prepend("<div class='alert alert-error'><button type='button' class='close' data-dismiss='alert'>×</button>#{file.name} is not a gif, jpeg, or png image file.</div>")
  #   done: (e, data) ->
  #     file = data.files[0]
  #     $("##{file.size}").fadeOut()
  #   progress: (e, data) ->
  #     if data.context
  #       progress = parseInt(data.loaded / data.total * 100, 10)
  #       data.context.find('.bar').css('width', progress + '%')