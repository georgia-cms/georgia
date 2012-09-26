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
    require 'acts_as_list'
    require 'kaminari'
    require 'pg'
    require 'pg_search'
    require 'ckeditor'
    require 'carrierwave'
    require 'draper'
    require 'backbone-on-rails'
    require 'henry'

    initializer 'georgia.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Georgia::FormActionsHelper
        helper Georgia::InternationalizationHelper
        helper Georgia::RoutesHelper
        helper Georgia::UiHelper
      end
    end

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end
    config.cache_classes = !(ENV['DRB'] == 'true')
  end
end