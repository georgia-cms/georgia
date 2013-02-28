class @Tags

  constructor: (element, context='tags', options={}) ->
    @el = $(element)
    @tags = []
    @context = context

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
      console.log query
      $.ajax(
        type: 'GET'
        url: '/api/tags/search'
        data: {q: query, c: @context}
        async: false
        success: (data) =>
          @tags = $.map(data.results, (e) => e.text)
      )
    @tags


$.fn.taggable = ->
  @each ->
    new Tags(this, $(this).data('token'))

jQuery ->
  $('input.js-token-input').taggable()