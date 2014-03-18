## Georgia

[![Gem Version](https://badge.fury.io/rb/georgia.png)](http://badge.fury.io/rb/georgia)
[![Build Status](https://travis-ci.org/georgia-cms/georgia.png?branch=master)](https://travis-ci.org/georgia-cms/georgia)
[![Code Climate](https://codeclimate.com/github/georgia-cms/georgia.png)](https://codeclimate.com/github/georgia-cms/georgia)
[![Coverage Status](https://coveralls.io/repos/georgia-cms/georgia/badge.png)](https://coveralls.io/r/georgia-cms/georgia)

Rails. Engine. CMS. Plug-and-play content management system for Ruby on Rails. Have a peak at the [demo](http://sorrynodemoyet.com/i-promise-it-s-on-its-way).

### Features

* Media library on the cloud
* Spam filter on emails
* Multilingual from the get-go
* Review you pairs and draft new pages
* Preview before publishing
* Rollback to previous revisions when it hits the fan
* Great UI, nice search, gravatars
* Editable menus
* Extendable
* Widgets
* Slides
* Permission levels

### Why? aka Comparison with refinerycms

* Because diversity is good.
* Because Georgia is a Rails Engine. You can add to an existing application.
* Because it's prettier.
* Because the guys on refinerycms did a great job and you should check them out.
* Because it's easy to start a website and push to Heroku.

### Getting started

Add Georgia to your Gemfile

    gem 'georgia'

Make sure you have properly identify your default locale and possible available ones.
Georgia uses available_locales to know which translations should be configured or not.

``` ruby
config.i18n.default_locale = :en
config.i18n.available_locales = [:en]
```

Then run the generator to mount routes, run migrations & setup initial instances.

    rails generate georgia:install

We built Georgia to help you quickly develop an application with a CMS (Content Management System). However, we don't want to be in your way when you need to customize it.

    rails generate georgia:views

Start your server (`rails server`) and go to [http://localhost:3000/admin](http://localhost:3000/admin) to get started.

### Cloud Storage

Georgia's media library stores your documents and images on the cloud. You'll need to configure the solution that best fits your needs. Two options for you: Cloudinary or Custom Storage with Fog (e.g. Amazon S3, Rackspace Cloud Files)

#### Cloudinary

This will only work if you plan to have only pictures/images in your Media Library. Cloudinary won't work for `.pdf` files and other documents.

1. Add cloudinary gem to your Gemfile.

    gem 'cloudinary'

2. Set storage to `:cloudinary` in the `config/initializers/georgia.rb` file.

    ``` ruby
    Georgia.setup do |config|
      ...

      # Storage
      config.storage = :cloudinary
    end
    ```

3. Open a Cloudinary Account

You can skip this step if you plan on using Heroku.

Take 10 seconds to open on account on Cloudinary if not already done. Download your `cloudinary.yml` file and add to your config.

#### Custom Storage

The `georgia:install` generator added a `carrierwave.example.rb` file to your initializers. Use it to configure

### Heroku

You will need certain addons to make it work. I suggest going with this list matching Georgia's default tools:

    heroku addons:add bonsai
    heroku addons:add sendgrid
    # optional
    heroku addons:add cloudinary

Add `config/initializers/bonsai.rb` with:

    ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL']

Create your indices with these commands:

    heroku run rake environment tire:import CLASS=Georgia::Page FORCE=true
    heroku run rake environment tire:import CLASS=Ckeditor::Asset FORCE=true
    heroku run rake environment tire:import CLASS=Ckeditor::Picture FORCE=true

Finally, create your first admin user to access to web panel:

    heroku run rake georgia:seed

For more information, you can also follow these [instructions](https://gist.github.com/nz/2041121) to setup bonsai.io. More [here](https://devcenter.heroku.com/articles/bonsai) on heroku.com