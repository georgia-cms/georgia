module Georgia
  class LinkDecorator < Georgia::ApplicationDecorator
    decorates :link, class: Georgia::Link
    decorates_association :page, with: Georgia::PageDecorator

    def url
      if text.match(/^http/)
        text
      else
        @url = text
        @url.insert(0, "/#{I18n.locale}") if I18n.available_locales.length > 1
        @url
      end
    end
  end
end