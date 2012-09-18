class Georgia.Models.Widget extends Backbone.RelationalModel
  urlRoot: '/api/widgets'

  relations: [
    type: Backbone.HasMany
    key: 'contents'
    relatedModel: 'Georgia.Models.Content'
    collectionType: 'Georgia.Collections.Contents'
    includeInJSON: false
    reverseRelation:
      key: 'widget'
      includeInJSON: false
  ]

  toJSON: ->
    widget:
      contents_attributes: this.get('contents').toJSON()

Georgia.Models.Widget.setup()