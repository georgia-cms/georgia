module Georgia
  class MenuObserver < ActiveRecord::Observer

    # observe Georgia::Menu

    # def after_create(menu)
    #   Georgia::Page.select(:id).each do |page|
    #     Georgia::MenuItem.find_or_create_by_page_id_and_menu_id(page.id, menu.id)
    #   end
    # end

  end
end