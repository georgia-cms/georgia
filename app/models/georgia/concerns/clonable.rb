require 'active_support/concern'

module Georgia
  module Concerns
    module Clonable
      extend ActiveSupport::Concern

      included do

        def clone
          Georgia::Clone.new(self).clone
        end

        def clone_as klass
          Georgia::Clone.new(self).clone_as(klass)
        end

        def clonable?
          true
        end

      end

    end
  end
end