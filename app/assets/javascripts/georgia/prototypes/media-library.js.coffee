class @MediaLibrary

  constructor: (element, target) ->
    @element            = $(element)
    @target             = null
    @picturesContainer  = @element.find("[data-media='results']")
    @search             = @element.find("[data-media='search']")
    @search.bind('change', @update)
    @element.on('click', "[data-media='results'] a[rel='next']", @changePage)
    @element.on('click', "[data-media='results'] a[rel='previous']", @changePage)
    @element.on('click', "[data-media='picture']", @select)
    @update()

  update: () =>
    @loadSpinner()
    url = '/admin/api/media/pictures'
    @performQuery(url)

  changePage: (event) =>
    @stopEvent(event)
    @loadSpinner()
    url = $(event.currentTarget).attr('href')
    @performQuery(url)

  select: (event) =>
    @stopEvent(event)
    @closeMediaLibrary()
    picture = $(event.currentTarget).clone()
    @target.find('.js-media-image').html(picture)
    @target.find('input').val(picture.data('media-id'))

  performQuery: (url) ->
    $.ajax(
      url: url
      data:
        query: @query
    ).done( (data) => @picturesContainer.html(data) )

  setTarget: (target) => @target = $(target)
  closeMediaLibrary: -> $('.js-close').trigger('click')
  loadSpinner: => @picturesContainer.html(@spinnerTag())
  stopEvent: (event) ->
    event.stopPropagation()
    event.preventDefault()

  query: => @search.val()
  spinnerTag: -> "<div class='spinner'><i class='fa fa-spinner fa-4x'></i></div>"

jQuery ->
  # If the media library modal is loaded,
  # Create a js object
  # When the 'choose image' button is clicked, reset the target
  if $("#media_library").length
    mediaLibrary = new MediaLibrary($("#media_library"))
    $('body').on('click', '.js-media-library', () ->
      mediaLibrary.setTarget($(this).data('media'))
    )