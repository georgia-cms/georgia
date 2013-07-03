# encoding: UTF-8
require 'rails/generators/migration'
require 'rails/generators/active_record'

module Georgia
  module Generators
    class UpgradeGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)

      desc "Upgrades Georgia CMS to fit latest changes"

      def self.next_migration_number(number)
        ActiveRecord::Generators::Base.next_migration_number(number)
      end

      def create_migration
        migration_template "change_georgia_content_excerpt_to_text.rb", "db/migrate/change_georgia_content_excerpt_to_text.rb"
      end

      def migrate
        rake 'db:migrate'
      end

      def create_guest_role
        rake 'georgia:upgrade'
      end

    end
  end
end