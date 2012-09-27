module Georgia
	class Role < ActiveRecord::Base
		
		attr_accessible :name

		has_and_belongs_to_many :admins
		
		validates :name, presence: true
	end
end