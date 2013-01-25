module Georgia
  class SlideDecorator < Georgia::ApplicationDecorator

    delegate :image, to: :content

    # FIXME: Should not override these and have tagline there
    def title
      h.content_tag(:strong, content.try(:title))
    end

    def text
      h.truncate(h.strip_tags(content.try(:text)), length: 100)
    end

    def tagline
      h.raw(content.text)
    end

  end
end