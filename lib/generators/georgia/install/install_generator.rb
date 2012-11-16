# encoding: UTF-8
require 'rails/generators/migration'

module Georgia
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      desc "Generate migration for Georgia CMS Models"

      def mount_engine
        route "root to: 'pages#show', slug: 'home'"
        route "resources :messages, only: [:create]"
        route "mount Georgia::Engine => '/admin'"
        route "mount Henry::Engine => '/api'"
        route "mount Ckeditor::Engine => '/ckeditor'"
        route "get '/:slug(/:slug)(/:slug)', to: 'pages#show', as: :page"
        route "resources :pages, only: [] do
          post '/preview', to: 'pages#preview', as: :preview, on: :member
        end"
      end

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def create_migration
        migration_template "migration.rb", "db/migrate/create_georgia_models.rb"
      end

      def copy_config
        template "config/initializers/georgia.rb"
      end

      def migrate
        rake "db:migrate"
      end

      def boostrap
        rake "georgia:setup"
      end

    end
  end
end