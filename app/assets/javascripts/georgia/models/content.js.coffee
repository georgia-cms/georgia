class Georgia.Models.Content extends Backbone.RelationalModel

  relations: [{
    type: Backbone.HasOne
    key:  'image'
    relatedModel: 'Georgia.Models.Image'
    collectionType: 'Georgia.Collections.Images'
    includeInJSON: false
    reverseRelation:
      key: 'content'
      includeInJSON: 'id'
  }]

  locales:
    en: 'English'
    fr: 'Français'
    ru: 'Russian'

  localeName: (locale) ->
    @locales[locale]

Georgia.Models.Content.setup()