# encoding: UTF-8
require 'rails/generators/migration'
require 'rails/generators/active_record'

module Georgia
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      desc "Installs Georgia CMS:\n
        * Mounts routes\n
        * Copies initializer\n
        * Loads Migration\n
        * Runs Migration\n
        * Creates initial instances"

      def mount_engine
        # Must be in reverse order to keep priorities
        route "get '*request_path', to: 'pages#show', as: :page"
        route "root to: 'pages#show', request_path: 'home'"
        route "resources :messages, only: [:create]"
        route "mount Ckeditor::Engine => '/ckeditor'"
        route "mount Georgia::Engine => '/admin'"
      end

      def self.next_migration_number(number)
        ActiveRecord::Generators::Base.next_migration_number(number)
      end

      def run_migrations
        rake "railties:install:migrations"
        rake "db:migrate"
      end

      def create_admin_user
        say("You're almost done. You need an admin user to get started.", :yellow)
        first_name = ask("First name:")
        last_name = ask("Last name:")
        email = ask("Email:")
        password = ask("Password:")
        Georgia::User.create(first_name: first_name, last_name: last_name, email: email, password: password, password_confirmation: password) do |user|
          user.roles << Georgia::Role.all
        end
      end

      def copy_templates
        template "config/initializers/georgia.rb"
        template "app/controllers/pages_controller.rb"
        template 'Procfile'
      end

      def add_dev_gems
        gem_group :development do
          gem "foreman"
          gem "sunspot_solr", '2.0.0'
        end
        run "bundle"
      end

      def show_readme
        readme "README"
      end

    end
  end
end