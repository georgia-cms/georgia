module Georgia
  class Portlet

    attr_accessor :view_context

    delegate :render, :portlet_tag, :content_tag, :icon_tag, :link_to, :hidden_field_tag, to: :view_context

    def initialize view_context, portlet, args={}
      @view_context = view_context
      @portlet = portlet
    end

    def id
      @id ||= @portlet.persisted? ? @portlet.id : Time.now.to_i
    end

    private

    def persisted?
      @portlet.persisted?
    end

  end
end