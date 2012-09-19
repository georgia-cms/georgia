module Georgia
  class WidgetDecorator < ApplicationDecorator
    decorates :widget
    decorates_association :versions

    def title
      h.content_tag(:strong, content.title) if content and content.title
    end

    def text
      h.truncate(h.strip_tags(content.text), length: 100) if content and content.text
    end

  end
end