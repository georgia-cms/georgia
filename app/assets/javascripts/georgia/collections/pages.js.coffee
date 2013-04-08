class Georgia.Collections.Pages extends Backbone.Collection
  url: '/api/pages'
  model: Georgia.Models.Page

  search: (query, options) ->
    @url = '/api/pages/search'
    @fetch($.extend(options, {data: {query: query}}))