jQuery ->
  $('#new_picture').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#new_picture').prepend(data.context)
        data.submit()
      else
        $("#new_picture").prepend("<div class='alert alert-error'><button type='button' class='close' data-dismiss='alert'>×</button>#{file.name} is not a gif, jpeg, or png image file.</div>")
    done: (e, data) ->
      file = data.files[0]
      $("##{file.size}").fadeOut()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')