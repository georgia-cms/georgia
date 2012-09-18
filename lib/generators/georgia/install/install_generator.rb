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

      def add_default_user_to_seeds
        append_file 'db/seeds.rb' do
          "
# Create an admin user to start playing around
Georgia::User.create(first_name: 'Mathieu', last_name: 'Gagné', email: 'mathieu@motioneleven.com', password: 'motion11', password_confirmation: 'motion11') do |user|
  user.roles << Georgia::Role.create(name: 'Admin')
  user.roles << Georgia::Role.create(name: 'Editor')
end"
        end
      end
    end
  end
end