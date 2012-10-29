module Georgia
  module MenusHelper

    def render_menu menu
      return unless menu and menu.is_a? Georgia::Menu
      links = Georgia::LinkDecorator.decorate(menu.links.ordered)
      if links.map(&:dropdown).include? true
        render 'menus/dropdown_menu', menu: menu, links: links
      else
        render 'menus/menu', menu: menu, links: links
      end
    end

    def render_links menu
      return unless menu and menu.is_a? Georgia::Menu
      render partial: 'menus/link', collection: Georgia::LinkDecorator.decorate(menu.links.ordered), as: :link
    end

  end
end