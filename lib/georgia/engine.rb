module Georgia
	class Engine < ::Rails::Engine
		isolate_namespace Georgia
		require 'rubygems'
		require 'jquery-rails'
		require 'simple_form'
		require 'twitter-bootstrap-rails'
		require 'bourbon'
		require 'devise'
		require 'cancan'
		require 'sass-rails'
		# require 'paper_trail'
		require 'acts_as_list'
		require 'kaminari'
		require 'pg'
		require 'pg_search'
		require 'ckeditor'
		require 'carrierwave'
		require 'draper'
	end
end