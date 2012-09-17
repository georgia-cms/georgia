module Georgia
	class ApplicationController < ActionController::Base

		# require 'devise'
		helper 'georgia/ui'
		helper 'georgia/internationalization'
		helper 'georgia/form_actions'

		protect_from_forgery
		
		before_filter :authenticate_user!, except: :login
		
		def login
			render 'users/sessions/new'
		end

		def current_ability
			@current_ability ||= Georgia::Ability.new(current_user)
		end
		
	end
end
