module Georgia
  module SidebarHelper

    def sidebar_navigation_link text, url, options={}
      SidebarLinkPresenter.new(self, text, url, options)
    end

    def sidebar_navigation_sublink text, url, options={}
      controller = options.fetch(:controller)
      content_tag :li, link_to(sidebar_title_tag(text), url), class: "#{'active' if controller_name == controller}"
    end

  end
end