module Georgia
	class Widget < ActiveRecord::Base

		has_many :ui_associations, dependent: :destroy
		has_many :ui_sections, through: :ui_associations
		has_many :pages, through: :ui_associations

		has_many :contents, as: :contentable, dependent: :destroy
		accepts_nested_attributes_for :contents
		attr_accessible :contents_attributes

	end
end