module Georgia
  class Engine < ::Rails::Engine
    isolate_namespace Georgia

    extend Georgia::Paths

    require 'rubygems'
    require 'zip'
    require 'simple_form'
    require 'devise'
    require 'kaminari'
    require 'ckeditor'
    require 'carrierwave'
    require 'elasticsearch/rails'
    require 'elasticsearch/model'
    require 'pundit'
    require 'draper'
    require 'ancestry'
    require 'acts-as-taggable-on'
    require 'sass-rails'
    require 'bourbon'
    require 'neat'
    require 'jquery-fileupload-rails'
    require 'jquery-rails'
    require 'jquery-ui-rails'
    require 'select2-rails'
    require 'shadowbox-rails'
    require 'mousetrap-rails'

  end
end