module Georgia
	class Users::SessionsController < ::Devise::SessionsController
		layout 'georgia/application'
	end
end