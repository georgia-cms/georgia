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
    require 'fuelux-rails'
    require 'henry'

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

    def self.app_path
      File.expand_path('../../app', called_from)
    end

    def self.decorator_path name
      File.expand_path("decorators/georgia/#{name}_decorator.rb", app_path)
    end

    %w{controller helper mailer model}.each do |resource|
      class_eval <<-RUBY
      def self.#{resource}_path(name)
        File.expand_path("#{resource.pluralize}/invitable/\#{name}.rb", app_path)
      end
      RUBY
    end

  end
end