class @MediaLibrary

  constructor: (element, target) ->
    @element            = $(element)
    @target             = null
    @picturesContainer  = @element.find(".pictures")
    @search             = @element.find("[data-media='search']")
    @search.bind('change', @update)
    @element.on('click', ".pictures a[rel='next']", @changePage)
    @element.on('click', ".pictures a[rel='previous']", @changePage)
    @element.on('click', "[data-media='picture']", @select)
    @update()

  update: () =>
    @loadSpinner()
    url = '/admin/api/media/pictures'
    @performQuery(url)

  changePage: (event) =>
    event.stopPropagation()
    event.preventDefault()
    @loadSpinner()
    url = $(event.currentTarget).attr('href')
    @performQuery(url)

  select: (event) =>
    event.stopPropagation()
    event.preventDefault()
    $('.js-close').trigger('click')
    picture = $(event.currentTarget).clone()
    @target.find('.media-image').html(picture)
    @target.find('input').val(picture.data('media-id'))

  setTarget: (target) =>
    @target = $(target)

  performQuery: (url) ->
    $.ajax(
      url: url
      data:
        query: @query
    ).done( (data) => @picturesContainer.html(data) )

  loadSpinner: () =>
    @picturesContainer.html(@spinnerTag())

  query: () =>
    @search.val()

  spinnerTag: () ->
    "<div class='spinner'><i class='fa fa-spinner fa-4x'></i></div>"

jQuery ->
  if $(".js-media-library").length
    mediaLibrary = new MediaLibrary($("#media_library"))
    $(".js-media-library").each ->
      target = $(this).data('media')
      $(this).click -> mediaLibrary.setTarget(target)
