class @AssetReplacer

  constructor: (element, options={}) ->
    @element = $(element)
    @input = @element.find('.js-replace-asset')
    @form = @element.find('form')
    @btn = @input.prev()
    @actions = @element.find('.media-actions')
    @bindEvents()

  bindEvents: () =>
    @input.on('change', @change)
    @element.on('mouseover', @toggleActions)
    @element.on('mouseout', @toggleActions)

  change: (e) =>
    @form.submit()
    @btn.html("<i class='fa fa-spinner fa-spin'></i> Uploading...")

  toggleActions: (e) =>
    @actions.toggle()

jQuery ->
  $('.js-media-editable').each (index, el) ->
    new AssetReplacer(el)