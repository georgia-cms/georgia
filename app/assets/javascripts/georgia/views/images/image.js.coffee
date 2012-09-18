class Georgia.Views.Image extends Backbone.View
  template: JST['images/image']
  tagName: 'li'
  className: 'span4'

  events:
    'click a.thumbnail': 'setFeatured'

  initialize: (options) ->
    @content = options.content

  render: ->
    $(@el).html(@template(image: @model))
    this

  setFeatured: (event) =>
    event.preventDefault()
    featured = $(@el).siblings('#featured_image')
    featured.find('a').attr('href', @model.attributes.url)
    featured.find('img').attr('src', @model.attributes.big_thumb_url)
    @content.trigger('updateImage', @model.id)