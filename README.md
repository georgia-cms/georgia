= Georgia

This project rocks and uses MIT-LICENSE.

== Getting started

Make sure you have properly identify your default locale and possible available ones.
Georgia uses available_locales to know which translations should be configured or not.

  config.i18n.default_locale = :en
  config.i18n.available_locales = [:en]

Then run the generator to mount routes, run migrations & setup initial instances.

  rails g georgia:install

Start your server (`rails server`) and go to (http://localhost:3000/admin)[http://localhost:3000/admin] to get started.

== Testing

=== Run rspec

  cd spec/dummy
  rspec spec