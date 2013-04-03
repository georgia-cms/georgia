# encoding: UTF-8
require 'rails/generators/migration'

module Georgia
  module Generators
    class UpgradeGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      desc "Upgrades Georgia CMS to fit latest changes"

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def create_migration
        migration_template "migration.rb", "db/migrate/upgrade_georgia.rb"
      end

    end
  end
end