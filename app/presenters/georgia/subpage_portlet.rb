module Georgia
  class SubpagePortlet < Portlet

    delegate :position, :title, :url, to: :portlet

    def to_s
      output = ActiveSupport::SafeBuffer.new
      output << handle_tag
      output << position_input_tag
      output << title_tag
      output << actions_tag
      portlet_tag(output)
    end

    private

    def position_input_tag
      hidden_field_tag("page_tree[#{id}][position]", position, class: 'js-position')
    end

    def title_tag
      content_tag(:h4, (title + url_tag).html_safe, class: 'title')
    end

    def url_tag
      content_tag(:small, url)
    end

    def actions_tag
      content_tag(:div, class: 'actions') do
        link_to(icon_tag('pencil'), [:edit, portlet])
      end
    end

  end
end