module Georgia
  module SidebarHelper

    def sidebar_navigation_link text, url, options={}
      SidebarLinkPresenter.new(self, text, url, options)
    end

    def sidebar_navigation_sublink text, url, options={}
      SidebarLinkPresenter.new(self, text, url, options).sidebar_navigation_sublink
    end

  end
end