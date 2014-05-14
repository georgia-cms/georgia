class Flash
  constructor: (message, type)->
    flash = $(".flash-container")
    flash.html("")

    $('<div/>',
      class: "flash-#{type}",
      html: message
    ).appendTo(".flash-container")

    flash.click -> $(@).fadeOut()
    flash.show()
    setTimeout (-> flash.fadeOut()), 5000

@Flash = Flash