module Georgia
	class Widget < ActiveRecord::Base

    include Georgia::Contentable

		has_many :ui_associations, dependent: :destroy
		has_many :ui_sections, through: :ui_associations
		has_many :pages, through: :ui_associations

	end
end