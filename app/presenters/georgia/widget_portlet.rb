module Georgia
  class WidgetPortlet

    attr_accessor :view_context

    delegate :render, :portlet_tag, :content_tag, :icon_tag, :link_to, :hidden_field_tag, to: :view_context

    def initialize view_context, ui_association, args={}
      @view_context = view_context
      @ui_association = ui_association
      @widget = args.fetch(:widget, ui_association.widget)
      @ui_section = args.fetch(:ui_section, ui_association.ui_section)
      @revision = args.fetch(:revision, ui_association.revision)
    end

    def to_s
      portlet_tag(@widget) do |p|
        hidden_field_tag("revision[ui_associations_attributes][#{id}][_destroy]", 0, class: 'js-destroy') +
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

    def id
      @id ||= @ui_association.persisted? ? @ui_association.id : Time.now.to_i
    end

  end
end