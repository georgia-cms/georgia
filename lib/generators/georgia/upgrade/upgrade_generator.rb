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

      def run_migrations
        migration_template "add_contents_counter_cache_to_images.rb", "db/migrate/add_contents_counter_cache_to_images.rb"
        rake 'db:migrate'
      end

    end
  end
end