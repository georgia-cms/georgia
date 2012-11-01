module Georgia
  class LinkDecorator < Georgia::ApplicationDecorator
    decorates :link, class: Georgia::Link
    decorates_association :page, with: Georgia::PageDecorator

    def url
      text
    end
  end
end