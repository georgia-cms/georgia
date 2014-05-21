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

      def add_default_indexer
        return if defined?(Sunspot)
        if !defined?(Tire)
          say("Adding Tire gem for Elasticsearch", :yellow)
          gem 'tire'
          Bundler.with_clean_env do
            run "bundle install"
          end
        end
        say("Creating elasticsearch indices", :yellow)
        rake "environment tire:import CLASS=Georgia::Page FORCE=true"
        rake "environment tire:import CLASS=Ckeditor::Asset FORCE=true"
        rake "environment tire:import CLASS=Ckeditor::Picture FORCE=true"
      end

    end
  end
end