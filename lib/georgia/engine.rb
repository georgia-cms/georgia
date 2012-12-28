module Georgia
  class Engine < ::Rails::Engine

    isolate_namespace Georgia

    require 'rubygems'
    require 'jquery-rails'
    require 'simple_form'
    require 'twitter-bootstrap-rails'
    require 'less-rails'
    require 'bourbon'
    require 'devise'
    require 'cancan'
    require 'sass-rails'
    require 'acts_as_list'
    require 'acts_as_revisionable'
    require 'kaminari'
    require 'pg'
    require 'pg_search'
    require 'ckeditor'
    require 'carrierwave'
    require 'draper'
    require 'handlebars_assets'
    require 'backbone-on-rails'
    require 'jquery-fileupload-rails'
    require 'ancestry'
    require 'acts-as-taggable-on'
    require 'select2-rails'
    require 'shadowbox-rails'
    require 'henry'

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( georgia/georgia.js georgia/georgia.css )
      Rails.application.config.assets.precompile += Ckeditor.assets
    end

    initializer 'georgia.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Georgia::DeviseHelper
        helper Georgia::FormActionsHelper
        helper Georgia::FormsHelper
        helper Georgia::InternationalizationHelper
        helper Georgia::RoutesHelper
        helper Georgia::UiHelper
        helper Georgia::MenusHelper
        helper Georgia::MetaTagsHelper
        helper Georgia::TwitterHelper
      end
    end

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end
    config.cache_classes = !(ENV['DRB'] == 'true')

  end
end