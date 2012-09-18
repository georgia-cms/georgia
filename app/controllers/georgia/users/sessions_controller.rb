module Georgia
	class Users::SessionsController < ::Devise::SessionsController
		layout 'georgia/application'
    helper 'georgia/routes'
	end
end