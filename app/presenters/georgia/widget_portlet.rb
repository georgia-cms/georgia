module Georgia
  class WidgetPortlet < Portlet

    def initialize view_context, ui_association, args={}
      @widget = args.fetch(:widget, ui_association.widget)
      @ui_section = args.fetch(:ui_section, ui_association.ui_section)
      @revision = args.fetch(:revision, ui_association.revision)
      super
    end

    def to_s
      output = ActiveSupport::SafeBuffer.new
      output << destroy_input_tag
      output << id_input_tag if persisted?
      output << ui_section_id_input_tag
      output << widget_id_input_tag
      output << page_id_input_tag
      output << title_tag
      output << actions_tag
      portlet_tag(output)
    end

    private

    def title
      @widget.title
    end

    def destroy_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][_destroy]", 0, class: 'js-destroy')
    end

    def id_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][id]", id)
    end

    def ui_section_id_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][ui_section_id]", @ui_section.id)
    end

    def widget_id_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][widget_id]", @widget.id)
    end

    def page_id_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][page_id]", @revision.id)
    end

    def title_tag
      content_tag(:span, title, class: "title")
    end

    def actions_tag
      content_tag(:div, class: 'actions') do
        link_to(icon_tag('times'), '#', class: 'btn-delete js-remove-widget')
      end
    end

  end
end