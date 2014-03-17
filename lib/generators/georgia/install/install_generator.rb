module Georgia
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
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

      def run_migrations
        rake "railties:install:migrations"
        rake "db:migrate"
      end

      def create_admin_user
        say("You're almost done. You need an admin user to get started.", :yellow)
        rake "georgia:seed"
      end

      def copy_templates
        copy_file "config/initializers/georgia.rb"
        copy_file "app/controllers/pages_controller.rb"
      end

      def create_indices
        if defined? Tire
          say("Creating elasticsearch indices", :yellow)
          rake "environment tire:import CLASS=Georgia::Page FORCE=true"
          rake "environment tire:import CLASS=Ckeditor::Asset FORCE=true"
        end
      end

      def show_readme
        readme "README"
      end

    end
  end
end