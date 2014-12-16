require 'rubygems'
require 'coveralls'
Coveralls.wear!

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara-webkit'
require 'coffee_script'
require 'factory_girl_rails'
require 'shoulda-matchers'
require 'database_cleaner'
require 'site_prism'

require 'rake'
require 'elasticsearch/extensions/test/cluster/tasks'
ENV["TEST_CLUSTER_NODES"] = "1"

Capybara.javascript_driver = :webkit

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false

  config.filter_run_excluding broken: true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.include Devise::TestHelpers, type: :controller
  config.include AuthenticationHelpers, type: :controller
  config.include AuthenticationHelpers, type: :feature
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end

end