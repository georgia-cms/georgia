module Georgia
  class Portlet < Presenter

    attr_reader :portlet

    def initialize view_context, portlet, args={}
      @portlet = portlet
      super
    end

    def id
      @id ||= @portlet.persisted? ? @portlet.id : rand(10 ** 8)
    end

    def portlet_tag content, options={}
      content_tag :li, content, options.reverse_merge(class: 'portlet', id: dom_id(portlet), data: {portlet: id})
    end

    def handle_tag
      content_tag(:span, icon_tag('ellipsis-v'), class: 'handle')
    end

    private

    def persisted?
      @portlet.persisted?
    end

  end
end