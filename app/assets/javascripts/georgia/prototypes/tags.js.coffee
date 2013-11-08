class @Tags

  constructor: (element, options={}) ->
    @el = $(element)
    @tags = []

    @options =
      placeholder: 'Enter tags'
      multiple: true
      tokenSeparators: [","]
      tags: () =>
        query = @el.select2('container').find('input.select2-input').val()
        @search(query)
    @options = $.extend {}, @options, options

    @el.select2(@options)

  search: (query='') ->
    if query?
      $.ajax(
        type: 'GET'
        url: '/admin/api/tags/search'
        data: {q: query}
        async: false
        success: (data) =>
          @tags = $.map(data.results, (e) => e.text)
      )
    @tags


$.fn.taggable = ->
  @each ->
    new Tags(this)

jQuery ->
  $('input.js-token-input').taggable()