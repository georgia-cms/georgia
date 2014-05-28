module Georgia
	class Role < ActiveRecord::Base

		has_many :users

		validates :name, presence: true, uniqueness: true
	end
end