require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'
  require 'factory_girl_rails'
  require 'shoulda-matchers'
  require 'draper/test/rspec_integration'
  require 'database_cleaner'
  require 'simplecov'

  DatabaseCleaner.strategy = :truncation

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  # Capybara.javascript_driver = :webkit
  # Capybara.javascript_driver = :selenium

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = false
    # config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false

    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    config.include AuthenticationHelpers
  end

end

Spork.each_run do
  DatabaseCleaner.clean
  FactoryGirl.reload
  SimpleCov.start 'rails' do
    add_filter 'spec'
    add_filter 'config'

    add_group 'Controllers', 'app/controllers'
    add_group 'Models', 'app/models'
    add_group 'Decorators', 'app/decorators'
    add_group 'Mailers', 'app/mailers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Libraries', 'lib'
    add_group 'Plugins', 'vendor/plugins'
  end
end
