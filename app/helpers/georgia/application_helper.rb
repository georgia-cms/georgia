module Georgia
	module ApplicationHelper
		def resource_name
			:georgia_user
		end

		def resource
			@resource ||= User.new
		end

		def devise_mapping
			@devise_mapping ||= Devise.mappings[:georgia_user]
		end
	end
end
