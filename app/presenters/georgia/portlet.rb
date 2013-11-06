module Georgia
  class Portlet

    attr_accessor :view_context

    delegate :render, :content_tag, :icon_tag, :link_to, :hidden_field_tag, :dom_id, to: :view_context

    def initialize view_context, portlet, args={}
      @view_context = view_context
      @portlet = portlet
    end

    def id
      @id ||= @portlet.persisted? ? @portlet.id : Time.now.to_i
    end

    def portlet_tag content, options={}
      content_tag :li, content, options.reverse_merge(class: 'portlet', id: dom_id(@portlet), data: {portlet: @portlet.id})
    end

    def handle_tag
      content_tag(:span, icon_tag('ellipsis-vertical'), class: 'handle')
    end

    private

    def persisted?
      @portlet.persisted?
    end

  end
end