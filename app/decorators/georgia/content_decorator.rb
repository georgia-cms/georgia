module Georgia
  class ContentDecorator < Georgia::ApplicationDecorator

    def title_or_none
      title.present? ? title : h.content_tag(:span, 'No title', class: 'muted')
    end

  end
end
