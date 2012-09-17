module Georgia
	class MenuItem < ActiveRecord::Base

		belongs_to :navigation_menu
		belongs_to :page

		scope :ordered, order('position ASC')
		scope :active, where(active: true)
		scope :inactive, where(active: false)

		class << self

			def activate ids
				ids.each_with_index do |id, index|
					update_all({active: true, position: index+1}, id: id)
				end
			end

			def deactivate ids
				update_all({active: false}, id: ids)
			end
		end
	end
end