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
    # require 'paper_trail'
    require 'henry'

    config.after_initialize do
      config.active_record.observers = Georgia::MenuObserver
      _ = ActiveRecord::Base if config.active_record.observers
    end
  end
end