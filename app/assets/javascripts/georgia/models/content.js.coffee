class Georgia.Models.Content extends Backbone.RelationalModel

  relations: [
    type: Backbone.HasOne
    key:  'image'
    relatedModel: 'Georgia.Models.Image'
    includeInJSON: false
    reverseRelation:
      type: Backbone.HasOne
      key: 'content'
      includeInJSON: false
  ]

  locales:
    en: 'English'
    fr: 'Français'

  localeName: (locale) ->
    @locales[locale]

Georgia.Models.Content.setup()