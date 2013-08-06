module Georgia
  class Engine < ::Rails::Engine

    isolate_namespace Georgia

    extend Georgia::Paths

    require 'rubygems'
    require 'henry'
    require 'zip/zip'
    require 'simple_form'
    require 'devise'
    require 'cancan'
    require 'acts_as_list'
    require 'acts-as-taggable-on'
    require 'kaminari'
    require 'pg'
    require 'pg_search'
    require 'ckeditor'
    require 'carrierwave'
    require 'draper'
    require 'ancestry'
    require 'cloudfiles'
    require 'sunspot_rails'
    require 'sunspot_solr'
    require 'state_machine'
    require 'activerecord-postgres-hstore'
    require 'activerecord-postgres-uuid'
    require 'uuidtools'
    require 'sendgrid'
    require 'routing_concerns'

    require 'backbone-on-rails'
    require 'handlebars_assets'
    require 'sass-rails'
    require 'bourbon'
    require 'jquery-fileupload-rails'
    require 'jquery-rails'
    require 'jquery-ui-rails'
    require 'bootstrap-rails'
    require 'select2-rails'
    require 'shadowbox-rails'
    require 'mousetrap-rails'

    initializer 'georgia.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Georgia::DeviseHelper
        helper Georgia::FormsHelper
        helper Georgia::RoutesHelper
        helper Georgia::UiHelper
        helper Georgia::MenusHelper
        helper Georgia::MetaTagsHelper
        helper Georgia::TwitterHelper
        helper Georgia::InternationalizationHelper
      end
    end

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end
    config.cache_classes = !(ENV['DRB'] == 'true')

  end
end