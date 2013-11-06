module Georgia
  class LinkPortlet < Portlet

    delegate :text_field_tag, :link_portlet_tag, to: :view_context

    def to_s
      form = ActiveSupport::SafeBuffer.new
      form << handle_tag
      form << link_form_fields
      form << actions_tag
      output = ActiveSupport::SafeBuffer.new
      output << content_tag(:div, form)
      output << (last_descendant? ? empty_portlet_list : children_portlets)
      portlet_tag(output)
    end

    private

    def children_portlets
      output = ActiveSupport::SafeBuffer.new
      sublinks.each do |link|
        output << link_portlet_tag(link)
      end
      content_tag(:ol, output, class: 'hide')
    end

    def empty_portlet_list
      content_tag(:ol, nil)
    end

    def link_form_fields
      content_tag(:span, class: 'link-form') do
        hidden_fields +
        label_field_tag +
        permalink_field_tag
      end
    end

    def hidden_fields
      hidden_field_tag("menu[links_attributes][#{id}][_destroy]", 0, class: 'js-destroy') +
      (hidden_field_tag("menu[links_attributes][#{id}][id]", id) if persisted?)
    end

    def label_field_tag
      text_field_tag(:title, @portlet.title, class: 'form-control input-label input-sm')
    end

    def permalink_field_tag
      text_field_tag(:text, @portlet.text, class: 'form-control input-permalink input-sm')
    end

    def expand_tag options={}
      options[:class] = 'toggle btn-action js-expand'
      options[:class] << ' hide' if last_descendant?
      link_to('#', options) {icon_tag('caret-down') + icon_tag('caret-up hide')}
    end

    def remove_tag
      link_to(icon_tag('times'), '#', class: 'btn-delete js-remove-link')
    end

    def actions_tag options={}
      content_tag(:div, class: 'actions') do
        expand_tag + remove_tag
      end
    end

    def last_descendant?
      !sublinks.any?
    end

    def sublinks
      @portlet.persisted? ? @portlet.children : []
    end

  end
end