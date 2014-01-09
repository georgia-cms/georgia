module Georgia
  class WidgetPortlet < Portlet

    delegate :position, to: :portlet
    delegate :title, to: :widget

    attr_reader :widget, :ui_section, :revision

    def initialize view_context, ui_association, args={}
      @widget = args.fetch(:widget, ui_association.widget)
      @ui_section = args.fetch(:ui_section, ui_association.ui_section)
      @revision = args.fetch(:revision, ui_association.revision)
      super
    end

    def to_s
      output = ActiveSupport::SafeBuffer.new
      output << sort_tag
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

    def sort_tag
      content_tag(:span, icon_tag('bars'), class: 'handle pull-left')
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

    def ui_section_id_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][ui_section_id]", ui_section.id)
    end

    def widget_id_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][widget_id]", widget.id)
    end

    def page_id_input_tag
      hidden_field_tag("revision[ui_associations_attributes][#{id}][page_id]", revision.id)
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