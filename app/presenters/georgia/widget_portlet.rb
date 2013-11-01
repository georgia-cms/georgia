module Georgia
  class WidgetPortlet < Portlet

    def initialize view_context, ui_association, args={}
      @widget = args.fetch(:widget, ui_association.widget)
      @ui_section = args.fetch(:ui_section, ui_association.ui_section)
      @revision = args.fetch(:revision, ui_association.revision)
      super
    end

    def to_s
      portlet_tag(@widget) do |p|
        hidden_field_tag("revision[ui_associations_attributes][#{id}][_destroy]", 0, class: 'js-destroy') +
        (hidden_field_tag("revision[ui_associations_attributes][#{id}][id]", id) if persisted?) +
        hidden_field_tag("revision[ui_associations_attributes][#{id}][ui_section_id]", @ui_section.id) +
        hidden_field_tag("revision[ui_associations_attributes][#{id}][widget_id]", @widget.id) +
        hidden_field_tag("revision[ui_associations_attributes][#{id}][page_id]", @revision.id) +
        content_tag(:span, title, class: "title") +
        content_tag(:div, class: 'actions') do
          link_to(icon_tag('times'), '#', class: 'btn-delete js-remove-widget')
        end
      end
    end

    def title
      @widget.title
    end

  end
end