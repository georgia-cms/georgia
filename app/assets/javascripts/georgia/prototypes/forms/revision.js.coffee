class @RevisionForm

  constructor: (element) ->
    @element = $(element)
    @title   = @element.find('.header-title')
    @titleTrigger = @title.find('a')
    @setBindings()

  setBindings: () =>
    @titleTrigger.on('mouseover', @toggleIcon)
    @titleTrigger.on('mouseout', @toggleIcon)
    @titleTrigger.on('click', @showInput)

  toggleIcon:  =>
    @title.find('i').toggle()
  showInput: =>
    @title.find('input').show()
    @title.find('h1').hide()

jQuery ->
  $('.js-revision-form').each () ->
    new RevisionForm(this)