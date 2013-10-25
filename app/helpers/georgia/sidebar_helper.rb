module Georgia
  module SidebarHelper

    def sidebar_navigation_link text, url, options={}
      controller = options.fetch(:controller)
      icon = options.fetch(:icon)
      content_tag :li, class: "#{'active' if controller_name == controller}" do
        link_to((content_tag(:span, icon_tag(icon), class: 'icon') + text), url)
      end
    end

  end
end