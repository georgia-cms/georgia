# encoding: UTF-8
require 'rails/generators/migration'

module Georgia
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      desc "Generate migration for Georgia CMS Models"

      def mount_engine
        route "mount Georgia::Engine => '/admin'"
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

    end
  end
end