module Georgia
	class Widget < ActiveRecord::Base

    include Georgia::Contentable

		has_many :ui_associations, dependent: :destroy
		has_many :ui_sections, through: :ui_associations
		has_many :pages, through: :ui_associations

    scope :footer, joins(:ui_sections).where(georgia_ui_sections: {name: 'Footer'})
    scope :submenu, joins(:ui_sections).where(georgia_ui_sections: {name: 'Submenu'})
    scope :sidebar, joins(:ui_sections).where(georgia_ui_sections: {name: 'Sidebar'})

    scope :for_page, lambda {|page| joins(:ui_associations).where(georgia_ui_associations: {page_id: page.id})}

	end
end