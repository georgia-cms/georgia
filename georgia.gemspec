# encoding: UTF-8
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
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rails', '>= 3.2.6'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'devise'
  s.add_dependency 'cancan'
  s.add_dependency 'simple_form'
  s.add_dependency 'draper'
  s.add_dependency 'kaminari'
  s.add_dependency 'fog', '> 1.12'
  s.add_dependency 'unf'
  s.add_dependency 'acts_as_list'
  s.add_dependency 'ckeditor', '4.0.8'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'bourbon'
  s.add_dependency 'neat'
  s.add_dependency 'sass-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'jquery-fileupload-rails'
  s.add_dependency 'ancestry'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'shadowbox-rails'
  s.add_dependency 'select2-rails'
  s.add_dependency 'rubyzip', '> 1'
  s.add_dependency 'cloudfiles' # unless for transfering files
  s.add_dependency 'mousetrap-rails'
  s.add_dependency 'state_machine'
  s.add_dependency 'sendgrid'
  s.add_dependency 'routing_concerns'
  s.add_dependency 'rakismet'
  s.add_dependency 'sidekiq'
end
