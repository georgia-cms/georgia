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
          "# encoding: UTF-8
# Create an admin user to start playing around
Georgia::Admin.create(first_name: 'Mathieu', last_name: 'Gagne', email: 'mathieu@motioneleven.com', password: 'motion11', password_confirmation: 'motion11') do |user|
  user.roles << Georgia::Role.create(name: 'Admin')
  user.roles << Georgia::Role.create(name: 'Editor')
end

Georgia::Status.create(name: 'Published', label: 'success', icon: 'icon-eye-open')
Georgia::Status.create(name: 'Pending Review', label: 'warning', icon: 'icon-time')
Georgia::Status.create(name: 'Draft', label: 'error', icon: 'icon-eye-close')
Georgia::Status.create(name: 'Incomplete', label: 'info', icon: 'icon-exclamation-sign')"
        end
      end
    end
  end
end