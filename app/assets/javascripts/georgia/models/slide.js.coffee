class Georgia.Models.Slide extends Backbone.RelationalModel
  urlRoot: '/api/slides'

  relations: [
    type: Backbone.HasMany
    key: 'contents'
    relatedModel: 'Georgia.Models.Content'
    collectionType: 'Georgia.Collections.Contents'
    reverseRelation:
      key: 'slide'
      includeInJSON: false
  ]

  toJSON: ->
    slide:
      page_id: this.attributes.page_id
      contents_attributes: this.get('contents').toJSON()

Georgia.Models.Slide.setup()