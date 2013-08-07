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
        migration_template "create_georgia_revisions.rb", "db/migrate/create_georgia_revisions.rb"
        migration_template "add_revision_id_to_georgia_slides.rb", "db/migrate/add_revision_id_to_georgia_slides.rb"
        migration_template "add_revision_id_to_georgia_ui_associations.rb", "db/migrate/add_revision_id_to_georgia_ui_associations.rb"
        rake 'db:migrate'
      end

      def run_upgrade_tasks
        rake 'georgia:upgrade:migrate_to_revisions'
      end

    end
  end
end