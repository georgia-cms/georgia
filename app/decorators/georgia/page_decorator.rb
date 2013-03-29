module Georgia
  class PageDecorator < Georgia::ApplicationDecorator

    PUBLISHED = 'Published'
    PENDING = 'Pending'
    UNDER_REVIEW = 'Waiting for Review'
    NOT_TRANSLATED = 'Missing Translation'
    SEO_INCOMPLETE = 'SEO Incomplete'

    delegate :image, to: :content

    def excerpt_or_text
      if content.excerpt and !content.excerpt.blank?
        h.raw(content.excerpt)
      elsif content.text and !content.text.blank?
        h.truncate(h.strip_tags(content.text), length: 255, separator: ' ').html_safe
      end
    end

    def url options={}
      localized_slug(options) + ancestry_url
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

    def localized_slug options={}
      if options[:locale].present?
        "/#{options[:locale]}/"
      else
        (I18n.available_locales.length > 1) ? "/#{I18n.locale.to_s}/" : '/'
      end
    end

    def ancestry_url
      (ancestors + [model]).map(&:slug).join("/")
    end

  end
end