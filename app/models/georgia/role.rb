module Georgia
	class Role < ActiveRecord::Base

  	attr_accessible :name if needs_attr_accessible?

		has_and_belongs_to_many :users, join_table: :roles_users

		validates :name, presence: true, uniqueness: true
	end
end