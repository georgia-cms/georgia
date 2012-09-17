module Georgia
  class PageDecorator < ApplicationDecorator
    decorates :page, class: Georgia::Page
    decorates_association :versions

    def title
      h.content_tag(:strong, content.title)
    end

    def text
      h.truncate(h.strip_tags(content.text), length: 100)
    end

    def url
      "/#{parent.present? ? "#{parent.slug}/#{model.slug}" : model.slug}"
    end

    def slug_tag
      h.content_tag :span, parent.present? ? "/#{parent.slug}/#{model.slug}" : model.slug, class: 'light'
    end

  end
end