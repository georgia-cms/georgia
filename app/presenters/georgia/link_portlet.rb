module Georgia
  class LinkPortlet < Portlet

    delegate :text_field_tag, :link_portlet_tag, to: :view_context

    def initialize view_context, link, args={}
      @content = args.fetch(:content, link.content)
      super
    end

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
      destroy_input_tag + (id_input_tag if persisted?) + locale_input_tag
    end

    def label_field_tag
      text_field_tag("menu[links_attributes][#{id}][contents_attributes][#{content_id}][title]", @content.title, class: 'form-control input-label input-sm', placeholder: 'Label')
    end

    def permalink_field_tag
      text_field_tag("menu[links_attributes][#{id}][contents_attributes][#{content_id}][text]", @content.text, class: 'form-control input-permalink input-sm', placeholder: 'Permalink, e.g. /my-url')
    end

    def destroy_input_tag
      hidden_field_tag("menu[links_attributes][#{id}][_destroy]", 0, class: 'js-destroy')
    end

    def id_input_tag
      hidden_field_tag("menu[links_attributes][#{id}][id]", id)
    end

    def locale_input_tag
      hidden_field_tag("menu[links_attributes][#{id}][contents_attributes][#{content_id}][locale]", @content.locale)
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

    def content_id
      @content.persisted? ? @content.id : 0
    end

    def dom_id portlet
      portlet.persisted? ? view_context.dom_id(portlet) : "link_#{id}"
    end

  end
end