module Georgia
  class UiAssociation < ActiveRecord::Base

   acts_as_list scope: :page
   
   belongs_to :page
   belongs_to :widget
   belongs_to :ui_section
   attr_accessible :position, :widget_id, :ui_section_id, :page_id

   scope :footer, includes(:ui_section).where(ui_sections: {name: 'Footer'})
   scope :submenu, includes(:ui_section).where(ui_sections: {name: 'Submenu'})
   scope :sidebar, includes(:ui_section).where(ui_sections: {name: 'Sidebar'})

   scope :for_page, lambda {|page_id| where(page_id: page_id)}

   validates :page_id, presence: true
   validates :ui_section_id, presence: true
   validates :widget_id, presence: true

 end
end