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
        migration_template "add_public_to_georgia_pages.rb", "db/migrate/add_public_to_georgia_pages.rb"
        migration_template "add_state_to_georgia_pages.rb", "db/migrate/add_state_to_georgia_pages.rb"
        migration_template "add_anti_spam_to_messages.rb", "db/migrate/add_anti_spam_to_messages.rb"
        migration_template "create_georgia_revisions.rb", "db/migrate/create_georgia_revisions.rb"
        migration_template "add_contents_counter_cache_to_images.rb", "db/migrate/add_contents_counter_cache_to_images.rb"
        rake 'db:migrate'
      end

      def run_tasks
        rake 'georgia:statuses'
        rake 'georgia:revisions'
      end

    end
  end
end