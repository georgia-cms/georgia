module Georgia
  module MenusHelper

    def render_menu menu
      return unless menu and menu.is_a? Georgia::Menu
      links = Georgia::LinkDecorator.decorate(menu.links.ordered)
      if links.map(&:dropdown).include? true
        render 'menus/dropdown_menu', links: links
      else
        render 'menus/menu', links: links
      end
    end

  end
end