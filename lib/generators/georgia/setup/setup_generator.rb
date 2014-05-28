require 'bundler'

module Georgia
  module Generators
    class SetupGenerator < ::Rails::Generators::Base

      desc "Setup Georgia CMS:\n
        * Runs Migration\n
        * Creates initial instances"

      def run_migrations
        rake "db:migrate"
      end

      def create_admin_user
        say("You're almost done. You need an admin user to get started.", :yellow)
        rake "georgia:seed"
      end

      def create_indexes
        Georgia::Page.__elasticsearch__.create_index!
        Ckeditor::Asset.__elasticsearch__.create_index!
        Ckeditor::Picture.__elasticsearch__.create_index!
        ActsAsTaggableOn::Tag.__elasticsearch__.create_index!
      end

    end
  end
end