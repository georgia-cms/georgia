class Georgia.Models.UiSection extends Backbone.RelationalModel

  relations: [{
    type: Backbone.HasMany,
    key: 'ui_associations',
    relatedModel: 'Georgia.Models.UiAssociation',
    collectionType: 'Georgia.Collections.UiAssociations',
    reverseRelation: {
      key: 'ui_section'
      includeInJSON: 'id'
    }
  }]


Georgia.Models.UiSection.setup()