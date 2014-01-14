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
        route "resources :pages, only: [] do
    get :preview, on: :member
  end"
        route "mount Georgia::Engine => '/admin'
  mount Ckeditor::Engine => '/ckeditor'\n"
      end

      def self.next_migration_number(number)
        ActiveRecord::Generators::Base.next_migration_number(number)
      end

      def run_migrations
        rake "railties:install:migrations"
        rake "db:migrate"
      end

      def copy_templates
        template "config/initializers/georgia.rb"
        template "app/controllers/pages_controller.rb"
      end

      def bootstrap
        rake "georgia:install"
      end

    end
  end
end