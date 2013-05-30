class Georgia.Models.Menu extends Backbone.RelationalModel
  urlRoot: '/api/menus'

  relations: [{
    type: Backbone.HasMany,
    key: 'links',
    relatedModel: 'Georgia.Models.Link',
    collectionType: 'Georgia.Collections.Links',
    reverseRelation: {
      key: 'link'
      includeInJSON: 'id'
    }
  }]

Georgia.Models.Menu.setup()