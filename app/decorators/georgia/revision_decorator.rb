module Georgia
  class RevisionDecorator < Georgia::ApplicationDecorator

    def excerpt_or_text
      if content.excerpt and !content.excerpt.blank?
        h.raw(content.excerpt)
      elsif content.text and !content.text.blank?
        h.truncate(h.strip_tags(content.text), length: 255, separator: ' ').html_safe
      end
    end

    def status_tag(options={})
      options[:class] ||= ''
      options[:class] << ' label'
      options[:class] << " label-#{human_state_name}"
      h.content_tag(:span, human_state_name, options)
    end

  end
end