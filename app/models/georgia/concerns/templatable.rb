require 'active_support/concern'

module Georgia
  module Concerns
    module Templatable
      extend ActiveSupport::Concern

      included do

        attr_accessible :template if needs_attr_accessible?

        validates :template, inclusion: {in: Georgia.templates, message: "%{value} is not a valid template" }

      end

      module ClassMethods
      end
    end
  end
end