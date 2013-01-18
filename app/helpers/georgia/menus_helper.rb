module Georgia
  module MenusHelper

    def render_menu menu
      return unless menu and menu.is_a? Georgia::Menu
      links = menu.links.ordered.decorate
      if links.map(&:dropdown).include? true
        render 'menus/dropdown_menu', menu: menu, links: links
      else
        render 'menus/menu', menu: menu, links: links
      end
    end

    def render_links menu
      return unless menu and menu.is_a? Georgia::Menu
      render partial: 'menus/link', collection: menu.links.ordered.decorate, as: :link
    end

  end
end