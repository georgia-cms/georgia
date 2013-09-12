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
  mount Henry::Engine => '/api'
  mount Ckeditor::Engine => '/ckeditor'\n"
      end

      def self.next_migration_number(number)
        ActiveRecord::Generators::Base.next_migration_number(number)
      end

      def run_migrations
        migration_template "db/migrate/create_ckeditor_assets.rb", "db/migrate/create_ckeditor_assets.rb"
        migration_template "db/migrate/create_georgia_contents.rb", "db/migrate/create_georgia_contents.rb"
        migration_template "db/migrate/create_georgia_links.rb", "db/migrate/create_georgia_links.rb"
        migration_template "db/migrate/create_georgia_menus.rb", "db/migrate/create_georgia_menus.rb"
        migration_template "db/migrate/create_georgia_messages.rb", "db/migrate/create_georgia_messages.rb"
        migration_template "db/migrate/create_georgia_pages.rb", "db/migrate/create_georgia_pages.rb"
        migration_template "db/migrate/create_georgia_revisions.rb", "db/migrate/create_georgia_revisions.rb"
        migration_template "db/migrate/create_georgia_roles.rb", "db/migrate/create_georgia_roles.rb"
        migration_template "db/migrate/create_georgia_slides.rb", "db/migrate/create_georgia_slides.rb"
        migration_template "db/migrate/create_georgia_ui_associations.rb", "db/migrate/create_georgia_ui_associations.rb"
        migration_template "db/migrate/create_georgia_ui_sections.rb", "db/migrate/create_georgia_ui_sections.rb"
        migration_template "db/migrate/create_georgia_users.rb", "db/migrate/create_georgia_users.rb"
        migration_template "db/migrate/create_georgia_widgets.rb", "db/migrate/create_georgia_widgets.rb"
        migration_template "db/migrate/create_roles_users.rb", "db/migrate/create_roles_users.rb"
        migration_template "db/migrate/create_tags.rb", "db/migrate/create_tags.rb"
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