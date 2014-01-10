module Georgia
  class SubpagePortlet < Portlet

    delegate :position, :title, to: :portlet

    def to_s
      output = ActiveSupport::SafeBuffer.new
      output << handle_tag
      output << destroy_input_tag
      output << position_input_tag
      output << id_input_tag if persisted?
      output << ui_section_id_input_tag
      output << widget_id_input_tag
      output << page_id_input_tag
      output << content_tag(:div, title_tag, class: 'pull-left')
      output << actions_tag
      portlet_tag(output)
    end

    private

    def text
      truncate(@widget.text, length: 70)
    end

    def destroy_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][_destroy]", 0, class: 'js-destroy')
    end

    def id_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][id]", id)
    end

    def position_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][position]", position, class: 'js-position')
    end

    def title_tag
      content_tag(:h4, (title + text_tag).html_safe, class: 'title')
    end

    def text_tag
      content_tag(:small, text)
    end

    def actions_tag
      content_tag(:div, class: 'actions') do
        link_to(icon_tag('times'), '#', class: 'js-remove-widget')
      end
    end

  end
end