require 'active_support/concern'

module Georgia
  module Concerns
    module Helpers
      extend ActiveSupport::Concern

      included do
        helper_method :instance_name
        helper_method :model
      end

      def instance_name
        controller_name.singularize
      end

      def model
        begin
          self.class.to_s.gsub(/Controller/,'').singularize.constantize
          # If no constant if found, check if the non-namespaced one exists. i.e. Partner => Admin::PartnersController
        rescue NameError
          self.class.to_s.gsub(/Controller/,'').gsub(/\w+::/,'').singularize.constantize
        end
      end

    end
  end
end
