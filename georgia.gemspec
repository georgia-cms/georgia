$:.push File.expand_path("../lib", __FILE__)

require "georgia/version"

Gem::Specification.new do |s|
  s.name        = "georgia"
  s.version     = Georgia::VERSION
  s.authors     = ["Mathieu Gagné"]
  s.email       = ["mathieu@motioneleven.com"]
  s.homepage    = "http://www.motioneleven.com/"
  s.summary     = "Motion Eleven's CMS Engine"
  s.description = "This is simply the best CMS in town. User authentication, widgets, slideshows, easy UI with drag and drop, publishing system, versioning, etc."

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails"
  s.add_dependency "devise"
  s.add_dependency "cancan"
  s.add_dependency "simple_form"
  s.add_dependency "draper"
  s.add_dependency "kaminari"
  s.add_dependency "fog"
  s.add_dependency "acts_as_list"
  s.add_dependency "acts_as_revisionable", "~> 1.2.2"
  s.add_dependency "differ"
  s.add_dependency "ckeditor"
  s.add_dependency "carrierwave"
  s.add_dependency "mini_magick"
  s.add_dependency 'therubyracer'
  s.add_dependency 'anjlab-bootstrap-rails'
  s.add_dependency 'font-awesome-sass-rails'
  s.add_dependency "bourbon"
  s.add_dependency 'sass-rails',   '~> 3.2.3'
  s.add_dependency 'coffee-rails', '~> 3.2.1'
  s.add_dependency 'pg'
  s.add_dependency 'pg_search'
  s.add_dependency 'backbone-on-rails', '0.9.2.3'
  s.add_dependency 'handlebars_assets'
  s.add_dependency 'jquery-fileupload-rails'
  s.add_dependency 'ancestry'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'shadowbox-rails'
  s.add_dependency 'select2-rails'
  s.add_dependency 'fuelux-rails'
  s.add_dependency 'rubyzip'
  s.add_dependency 'cloudfiles'
  s.add_dependency 'mousetrap-rails'

  s.add_development_dependency "thin"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "debugger"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "rb-inotify"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'brakeman'
  s.add_development_dependency 'rails_best_practices'
  s.add_development_dependency 'bullet'
end