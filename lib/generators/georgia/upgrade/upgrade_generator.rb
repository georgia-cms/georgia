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
        migration_template "add_type_to_georgia_pages.rb", "db/migrate/add_type_to_georgia_pages.rb"
        migration_template "add_position_to_georgia_widgets.rb", "db/migrate/add_position_to_georgia_widgets.rb"
        migration_template "add_phone_to_georgia_messages.rb", "db/migrate/add_phone_to_georgia_messages.rb"
        migration_template "add_url_to_georgia_pages.rb", "db/migrate/add_url_to_georgia_pages.rb"
      end

    end
  end
end