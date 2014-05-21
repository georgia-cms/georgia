require 'active_support/concern'

module Georgia
  module Concerns
    module Orderable
      extend ActiveSupport::Concern

      included do

        acts_as_list
        attr_accessible :position if needs_attr_accessible?

        scope :ordered, order(:position)

      end

      module ClassMethods
      end
    end
  end
end