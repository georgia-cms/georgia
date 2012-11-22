# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/environments/test.rb')
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch('test/test_helper.rb') { :test_unit }
  watch(%r{features/support/}) { :cucumber }
  watch(%r{^app/models/.+\.rb$})
end

require 'active_support/inflector'
guard 'rspec', version: 2, cli: '--profile --drb --color --format documentation', all_on_start: false, all_after_pass: false do
  watch(%r{^spec/.+_spec\.rb$})                                   { "spec" }
  watch(%r{^lib/(.+)\.rb$})                                       { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')                                    { "spec" }
  watch(%r{^spec/support/(.+)\.rb$})                              { "spec" }
  watch('config/routes.rb')                                       { "spec/routing" }
  watch('spec/dummy/config/routes.rb')                            { "spec/routing" }

  # Factory Girl
  watch(%r{^spec/factories/(.+)\.rb$}) do |m|
    %W[
      spec/models/#{m[1].singularize}_spec.rb
      spec/controllers/#{m[1]}_controller_spec.rb
      spec/requests/#{m[1]}_spec.rb
    ]
  end

  watch(%r{^app/(.+)\.rb$})                                       { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/dummy/app/(.+)\.rb$})                            { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                             { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^spec/dummy/app/(.*)(\.erb|\.haml)$})                  { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})              { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/dummy/app/controllers/(.+)_(controller)\.rb$})   { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch('app/controllers/application_controller.rb')              { "spec/controllers" }
  watch('spec/dummy/app/controllers/application_controller.rb')   { "spec/controllers" }

  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})                      { |m| "spec/requests/#{m[1]}_spec.rb" }
  watch(%r{^spec/dummy/app/views/(.+)/.*\.(erb|haml)$})           { |m| "spec/requests/#{m[1]}_spec.rb" }
end