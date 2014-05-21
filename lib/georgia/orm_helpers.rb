require 'active_support/concern'

module Georgia
  module OrmHelpers
    extend ActiveSupport::Concern

    module ClassMethods
      def needs_attr_accessible?
        rails_3? && !strong_parameters_enabled?
      end

      def rails_3?
        Rails::VERSION::MAJOR == 3
      end

      def strong_parameters_enabled?
        defined?(ActionController::StrongParameters)
      end
    end

  end
end