module Georgia
  class SidebarLinkPresenter < Presenter

    attr_reader :text, :url, :icon, :options, :active
    alias :active? :active

    def initialize view_context, text, url, options={}
      @view_context = view_context
      @text = text
      @url = url
      @options = options
      @icon = options.fetch(:icon, 'bookmark-o')
      @active = options.fetch(:active, get_active_state_from_controller)
      super
    end

    def to_s
      content_tag :li, class: "#{'active' if active?}" do
        link_to(sidebar_link_bundle, url)
      end
    end

    def sidebar_navigation_sublink
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
      controller_name == controller
    end

  end
end