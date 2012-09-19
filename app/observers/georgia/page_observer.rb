module Georgia
  class PageObserver < ActiveRecord::Observer

    observe Georgia::Page

    def after_create(page)
      Georgia::Menu.select(:id).each do |menu|
        Georgia::MenuItem.find_or_create_by_page_id_and_menu_id(page.id, menu.id)
      end
    end

  end
end