module Georgia
	class Ability
		include CanCan::Ability

		def initialize(user)
			user ||= Georgia::Admin.new

			user.roles.each do |role|
				if role.name == 'Admin'
					can :manage, :all
				end

				if role.name == 'Editor'
					can :publish, :all
					can :unpublish, :all
					can :ask_for_review, :all
				end
			end
		end
	end
end