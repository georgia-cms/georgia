module Georgia
	class Users::SessionsController < ::Devise::SessionsController
		layout 'georgia/devise'
    helper 'georgia/routes'
	end
end