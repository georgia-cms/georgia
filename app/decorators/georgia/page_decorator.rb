module Georgia
  class PageDecorator < Georgia::ApplicationDecorator

    def excerpt_or_text
      if content.excerpt and !content.excerpt.blank?
        h.raw(content.excerpt)
      elsif content.text and !content.text.blank?
        h.truncate(h.strip_tags(content.text), length: 255, separator: ' ').html_safe
      end
    end

    def status_tag
      h.content_tag(:span, class: "label label-#{human_state_name}") do
        human_state_name
      end
    end

    def template_path
      "pages/templates/#{model.template}"
    end

  end
end