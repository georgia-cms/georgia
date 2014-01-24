## Georgia

This project rocks and uses MIT-LICENSE.

### Getting started

Make sure you have properly identify your default locale and possible available ones.
Georgia uses available_locales to know which translations should be configured or not.

    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en]

Then run the generator to mount routes, run migrations & setup initial instances.

  rails g georgia:install

Start your server (`rails server`) and go to [http://localhost:3000/admin](http://localhost:3000/admin) to get started.

#### Heroku

You will need certain addons to make it work. I suggest going with this list matching Georgia's default tools:

    heroku addons:add bonsai
    heroku addons:add sendgrid

### Testing

#### Run rspec

    cd spec/dummy
    rspec spec