module Georgia
  class WidgetDecorator < ApplicationDecorator

    delegate :image, to: :content

    def title
      h.content_tag(:strong, content.try(:title))
    end

    def text
      h.truncate(h.strip_tags(content.try(:text)), length: 100)
    end

  end
end