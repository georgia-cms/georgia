module Georgia
	class Admins::SessionsController < ::Devise::SessionsController
		layout 'georgia/application'
    helper 'georgia/routes'
	end
end