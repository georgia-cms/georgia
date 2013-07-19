# encoding: UTF-8
require 'rails/generators/migration'

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
        route "mount Georgia::Engine => '/admin'"
        route "mount Henry::Engine => '/api'"
        route "mount Ckeditor::Engine => '/ckeditor'"
        route "root to: 'pages#show', slug: 'home'"
        route "resources :messages, only: [:create]"
        route "get '*path', to: 'pages#show', as: :page"
      end

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def create_migration
        migration_template "migration.rb", "db/migrate/create_georgia_models.rb"
      end

      def copy_templates
        template "config/initializers/georgia.rb"
        template "app/controllers/pages_controller.rb"
      end

      def migrate
        rake "db:migrate"
      end

      def bootstrap
        rake "georgia:install"
      end

    end
  end
end