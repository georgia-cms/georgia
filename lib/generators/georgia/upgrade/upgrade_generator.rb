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
        migration_template "drop_georgia_statuses.rb", "db/migrate/drop_georgia_statuses.rb"
        migration_template "add_uuid_to_georgia_pages.rb", "db/migrate/add_uuid_to_georgia_pages.rb"
        migration_template "add_state_to_georgia_pages.rb", "db/migrate/add_state_to_georgia_pages.rb"
      end

      def add_preview_route
        route "resources :pages, only: [] do
    get :preview, on: :member
  end"
      end

      def migrate
        rake 'db:migrate'
      end

    end
  end
end