class Georgia.Models.Page extends Backbone.RelationalModel
  urlRoot: '/api/pages'

  relations: [{
    type: Backbone.HasMany
    key: 'contents'
    relatedModel: 'Georgia.Models.Content'
    collectionType: 'Georgia.Collections.Contents'
    includeInJSON: false
    reverseRelation:
      key: 'page'
      includeInJSON: false
    }]

  toJSON: ->
    page:
      contents_attributes: this.get('contents').toJSON()

Georgia.Models.Page.setup()