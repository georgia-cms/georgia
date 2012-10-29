module Georgia
  class WidgetDecorator < ApplicationDecorator
    decorates :widget, class: Georgia::Widget
    # decorates_association :versions

    def title
      h.content_tag(:strong, content.try(:title))
    end

    def text
      h.truncate(h.strip_tags(content.try(:text)), length: 100)
    end

    def image
      content.try(:image)
    end

  end
end