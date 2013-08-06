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

  s.add_dependency 'henry', '0.5.0'
  s.add_dependency 'rails', '~> 3.2.13'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'devise'
  s.add_dependency 'cancan'
  s.add_dependency 'simple_form'
  s.add_dependency 'draper'
  s.add_dependency 'kaminari'
  s.add_dependency 'fog', '> 1.12'
  s.add_dependency 'acts_as_list'
  s.add_dependency 'ckeditor'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'therubyracer'
  s.add_dependency 'anjlab-bootstrap-rails' # needed for loading individual javascript components
  s.add_dependency 'bourbon'
  s.add_dependency 'sass-rails',   '~> 3.2.3' # no need to specify version?
  s.add_dependency 'coffee-rails', '~> 3.2.1' # no need to specify version?
  s.add_dependency 'backbone-on-rails', '0.9.2.3' #should be upgraded
  s.add_dependency 'handlebars_assets'
  s.add_dependency 'jquery-fileupload-rails' # should use remotipart instead
  s.add_dependency 'ancestry'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'shadowbox-rails'
  s.add_dependency 'select2-rails'
  s.add_dependency 'rubyzip'    # not sure it's really needed
  s.add_dependency 'cloudfiles' # unless for transfering files
  s.add_dependency 'mousetrap-rails'
  s.add_dependency 'pg' # should be database agnostic
  s.add_dependency 'pg_search' # should be remove
  s.add_dependency 'sunspot_rails'
  s.add_dependency 'sunspot_solr' # should be a development requirement and installed properly on production
  s.add_dependency 'state_machine'
  s.add_dependency 'sendgrid'
  s.add_dependency 'routing_concerns'

  s.add_development_dependency 'thin'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'debugger'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara', "~>2.0.3"
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rb-inotify'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'brakeman'
  s.add_development_dependency 'rails_best_practices'
  s.add_development_dependency 'bullet'
  s.add_development_dependency 'foreman'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-rails'
end
