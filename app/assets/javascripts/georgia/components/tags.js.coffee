class @Tags

  constructor: (element, options={}) ->
    @el = $(element)
    @el.textext(
      plugins: 'autocomplete ajax tags arrow'
      tags:
        items: @initTags()
      ajax:
        url: '/admin/api/tags/'
        type: 'GET'
        cacheResults: true
    )

  initTags: () =>
    tags = @el.text().split(', ')
    @el.text('')
    tags

$.fn.taggable = ->
  @each ->
    new Tags(this)

jQuery ->
  $('textarea.js-taggable').taggable()