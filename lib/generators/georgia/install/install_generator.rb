module Georgia
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Installs Georgia CMS:\n
        * Mounts routes\n
        * Copies initializer\n
        * Loads Migration"

      def mount_engine
        # Must be in reverse order to keep priorities
        route "# root to: 'pages#show', request_path: 'home'"
        route "# get '*request_path', to: 'pages#show', as: :page"
        route "mount Ckeditor::Engine => '/ckeditor'"
        route "mount Georgia::Engine => '/admin'"
      end

      def run_migrations
        rake "railties:install:migrations"
      end

      def copy_templates
        copy_file "config/initializers/georgia.rb"
        copy_file "config/initializers/carrierwave.example.rb"
        copy_file "app/controllers/pages_controller.rb"
      end

      def show_readme
        readme "README"
      end

    end
  end
end