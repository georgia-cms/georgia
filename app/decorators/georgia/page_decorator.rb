module Georgia
  class PageDecorator < Georgia::ApplicationDecorator

    def excerpt_or_text
      if content.excerpt and !content.excerpt.blank?
        h.raw(content.excerpt)
      elsif content.text and !content.text.blank?
        h.truncate(h.strip_tags(content.text), length: 255, separator: ' ').html_safe
      end
    end

    def url options={}
      '/' + localized_slug(options) + ancestry_url
    end

    def status_tag
      h.content_tag(:span, class: "label label-#{status.try(:label)}") do
        h.raw(h.icon_tag("icon-white #{status.try(:icon)}") + ' ' + status.try(:name))
      end
    end

    def template_path
      "pages/templates/#{model.template}"
    end

    protected

    def localized_slug options={}
      locale = options[:locale] || I18n.locale.to_s
      (I18n.available_locales.length > 1) ? "#{locale}/" : ''
    end

    def ancestry_url
      (ancestors + [model]).map(&:slug).join('/')
    end

  end
end