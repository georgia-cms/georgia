class Georgia.Models.UiAssociation extends Backbone.RelationalModel
  urlRoot: '/api/ui_associations'

  relations: [{
    type: Backbone.HasOne
    key:  'ui_section'
    relatedModel: 'Georgia.Models.UiSection'
    collectionType: 'Georgia.Collections.UiSections'
    includeInJSON: false
    reverseRelation:
      key: 'ui_section_id'
      includeInJSON: 'id'
    },{
    type: Backbone.HasOne
    key:  'widget'
    relatedModel: 'Georgia.Models.Widget'
    collectionType: 'Georgia.Collections.Widgets'
    includeInJSON: false
    reverseRelation:
      key: 'widget_id'
      includeInJSON: 'id'
    }]

Georgia.Models.UiAssociation.setup()