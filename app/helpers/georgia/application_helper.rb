module Georgia
	module ApplicationHelper
		def resource_name
			:georgia_admin
		end

		def resource
			@resource ||= Georgia::Admin.new
		end

		def devise_mapping
			@devise_mapping ||= Devise.mappings[:georgia_admin]
		end
	end
end
