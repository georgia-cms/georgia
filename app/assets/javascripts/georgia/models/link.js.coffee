class Georgia.Models.Link extends Backbone.RelationalModel
  urlRoot: '/api/links'

  relations: [{
    type: Backbone.HasMany
    key: 'contents'
    relatedModel: 'Georgia.Models.Content'
    collectionType: 'Georgia.Collections.Contents'
    includeInJSON: false
    reverseRelation:
      key: 'link'
      includeInJSON: false
    }, {
    type: Backbone.HasOne
    key:  'menu'
    relatedModel: 'Georgia.Models.Menu'
    collectionType: 'Georgia.Collections.Menus'
    includeInJSON: false
    reverseRelation:
      key: 'content'
      includeInJSON: 'id'
    }, {
    type: Backbone.HasMany
    key: 'links'
    relatedModel: 'Georgia.Models.Link'
    collectionType: 'Georgia.Collections.Links'
    includeInJSON: false
    reverseRelation:
      key: 'link'
      includeInJSON: false
    }]

  toJSON: ->
    link:
      menu_id: this.attributes.menu_id
      contents_attributes: this.get('contents').toJSON()

Georgia.Models.Link.setup()