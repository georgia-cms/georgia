module Georgia
  module SidebarHelper

    def sidebar_navigation_link text, url, options={}
      controller = options.fetch(:controller)
      icon = options.fetch(:icon, 'bookmark-o')
      content_tag :li, class: "#{'active' if controller_name == controller}" do
        link_to((sidebar_link_bundle(icon, text)), url)
      end
    end

    def sidebar_navigation_sublink text, url, options={}
      controller = options.fetch(:controller)
      content_tag :li, link_to(sidebar_title_tag(text), url), class: "#{'active' if controller_name == controller}"
    end

    private

    def sidebar_link_bundle icon, text
      sidebar_title_icon(icon) + sidebar_title_tag(text) + sidebar_arrow_icon
    end

    def sidebar_title_icon icon
      content_tag(:span, icon_tag(icon), class: 'icon')
    end

    def sidebar_arrow_icon
      content_tag(:span, icon_tag('angle-left'), class: 'arrow')
    end

    def sidebar_title_tag text
      content_tag(:h5, text, class: 'sidebar-link-name')
    end

  end
end