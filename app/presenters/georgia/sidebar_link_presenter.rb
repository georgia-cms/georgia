module Georgia
  class SidebarLinkPresenter < Presenter

    attr_reader :text, :url, :icon, :options, :active, :sublink
    alias :active? :active
    alias :sublink? :sublink

    def initialize view_context, text, url, options={}
      @view_context = view_context
      @text = text
      @url = url
      @options = options
      @icon = options.fetch(:icon, 'bookmark-o')
      @active = options.fetch(:active, get_active_state_from_controller)
      @sublink = options.fetch(:sublink, false)
      super
    end

    def to_s
      !sublink? ? render_link : render_sublink
    end

    def render_link
      content_tag :li, link_to(sidebar_link_bundle, url), class: "#{'active' if active?}"
    end

    def render_sublink
      content_tag :li, link_to(sidebar_title_tag, url), class: "#{'active' if active?}"
    end

    private

    def sidebar_link_bundle
      sidebar_title_icon + sidebar_title_tag + sidebar_arrow_icon
    end

    def sidebar_title_icon
      content_tag(:span, icon_tag(icon), class: 'icon')
    end

    def sidebar_arrow_icon
      content_tag(:span, icon_tag("angle-#{active? ? 'right' : 'left'}"), class: 'arrow')
    end

    def sidebar_title_tag
      content_tag(:h5, text, class: 'sidebar-link-name')
    end

    def get_active_state_from_controller
      controller = options.fetch(:controller)
      controller.is_a?(Array) ? controller.include?(controller_name) : (controller_name == controller)
    end

  end
end