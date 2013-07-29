require 'active_support/concern'

module Georgia
  module Concerns
    module Copyable
      extend ActiveSupport::Concern

      included do

        def copy
          Georgia::Clone.new(self).copy
        end

        def clone_as klass
          Georgia::Clone.new(self).clone_as(klass)
        end

        def copyable?
          true
        end

      end

    end
  end
end