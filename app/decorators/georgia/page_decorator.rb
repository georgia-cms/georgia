module Georgia
  class PageDecorator < ApplicationDecorator
    # decorates_association :slides

    delegate :current_page, :total_pages, :limit_value, to: :source

    PUBLISHED = 'Published'
    PENDING = 'Pending'
    UNDER_REVIEW = 'Waiting for Review'
    NOT_TRANSLATED = 'Missing Translation'
    SEO_INCOMPLETE = 'SEO Incomplete'

    def excerpt_or_text
      if content.excerpt and !content.excerpt.blank?
        h.raw(content.excerpt)
      else
        h.truncate(h.strip_tags(content.text), length: 255)
      end
    end

    def url
      "/" + (ancestors + [model]).map(&:slug).join("/")
    end

    def full_url
      Georgia.url + url
    end

    def slug_tag
      h.content_tag :span, parent.present? ? "/#{parent.slug}/#{model.slug}" : model.slug, class: 'light'
    end

    def status_tag
      h.content_tag(:span, class: "label label-#{status.try(:label)}") do
        h.raw(h.icon_tag("icon-white #{status.try(:icon)}") + ' ' + status.try(:name))
      end
    end

    def template_path
      "pages/templates/#{model.template}"
    end

  end
end