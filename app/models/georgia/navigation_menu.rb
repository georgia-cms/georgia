module Georgia
	class NavigationMenu < ActiveRecord::Base

		attr_accessible :name

		has_many :menu_items, dependent: :destroy
		has_many :pages, through: :menu_items

	end
end