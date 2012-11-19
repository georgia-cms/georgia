module Georgia
  class SlideDecorator < ApplicationDecorator
    decorates :slide, class: Georgia::Slide

    def title
      h.content_tag(:strong, content.try(:title))
    end

    def text
      h.truncate(h.strip_tags(content.try(:text)), length: 100)
    end

    def image
      content.image
    end

  end
end