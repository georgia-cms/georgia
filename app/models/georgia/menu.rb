module Georgia
	class Menu < ActiveRecord::Base

		attr_accessible :name

		has_many :menu_items, dependent: :destroy
		has_many :pages, through: :menu_items

    # Stays inside model and not exported to observers folder because
    # for some reason the config.active_record.observers is loaded before the observer is first initialized
    after_create do
      Page.select(:id).each do |page|
        MenuItem.find_or_create_by_page_id_and_menu_id(page.id, self.id)
      end
    end

	end
end