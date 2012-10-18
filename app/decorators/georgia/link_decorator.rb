module Georgia
  class LinkDecorator < Georgia::ApplicationDecorator
    decorates :link, class: Georgia::Link
    decorates_association :page, with: Georgia::PageDecorator
  end
end