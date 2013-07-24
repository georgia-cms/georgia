module Georgia
  class PageDecorator < Georgia::ApplicationDecorator

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
      if model.is_a? Georgia::MetaPage
        options[:class] << " label-#{human_state_name}"
        h.content_tag(:span, human_state_name, options)
      else
        options[:class] << " label-#{non_namespaced_class_name}"
        h.content_tag(:span, non_namespaced_class_name, options)
      end
    end

    def template_path
      "pages/templates/#{model.template}"
    end

    private

    def non_namespaced_class_name
      @non_namespaced_class_name ||= model.class.to_s.underscore.gsub(/.*\/(.*)/, '\1')
    end

  end
end