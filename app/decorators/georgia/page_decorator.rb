module Georgia
  class PageDecorator < Georgia::ApplicationDecorator
    decorates_association :current_revision

    delegate :excerpt_or_text, to: :current_revision

    def template_path
      "pages/templates/#{current_revision.template}"
    end

    def state_icon
      if public?
        h.icon_tag('icon-ok icon-success')
      else
        h.icon_tag('icon-remove icon-failure')
      end
    end

    def status_tag(options={})
      options[:class] ||= ''
      options[:class] << ' label'
      options[:class] << " label-#{public? ? 'success' : 'warning'}"
      h.content_tag(:span, state, options)
    end

    def state
      public? ? 'public' : 'private'
    end

  end
end