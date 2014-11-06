$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "georgia/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "georgia"
  s.version     = Georgia::VERSION
  s.authors     = ["Mathieu Gagné"]
  s.email       = ["gagne.mathieu@hotmail.com"]
  s.homepage    = "http://www.georgiacms.org"
  s.summary     = "Rails CMS Engine"
  s.description = "This is simply the best CMS in town. User authentication, widgets, slideshows, easy UI with drag and drop, publishing system, versioning, etc."
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency 'highline'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails', '~> 5.0'
  s.add_dependency 'devise'
  s.add_dependency 'simple_form'
  s.add_dependency 'draper'
  s.add_dependency 'kaminari'
  s.add_dependency 'fog', '> 1.12'
  s.add_dependency 'unf'
  s.add_dependency 'ckeditor', '~> 4.0'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'bourbon'
  s.add_dependency 'neat'
  s.add_dependency 'sass-rails', '~> 4.0.3'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'jquery-fileupload-rails'
  s.add_dependency 'ancestry'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'select2-rails'
  s.add_dependency 'rubyzip', '> 1'
  s.add_dependency 'mousetrap-rails'
  s.add_dependency 'elasticsearch-rails'
  s.add_dependency 'elasticsearch-model'
  s.add_dependency 'pundit'
  s.add_dependency 'public_activity', '~> 1.4'
  s.add_dependency 'icon_tag', '~> 0.0.2'

  s.add_development_dependency "sqlite3"
end